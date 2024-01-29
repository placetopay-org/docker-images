import requests
from bitbucket_pipes_toolkit import Pipe, yaml
import keepachangelog
import os
import markdownify

BASE_SUCCESS_MESSAGE = "Notification successful"
BASE_FAILED_MESSAGE = "Notification failed"

schema = {
    "WEBHOOK_URL": {
        "type": "string",
        "required": True
    },
    "MESSAGE": {
        "type": "string",
        "required": True
    },
    "FILENAME": {
        "type": "string",
        "required": False
    },
    "WEBHOOK_TYPE": {
        "type": "string",
        "required": True
    }
}


class TeamsNotifyPipe(Pipe):

    def getPayload(self, webhookType, text):
        payload = {
            "INCOMING_WEBHOOK": {
                "@type": "MessageCard",
                "themeColor": "E56822",
                "text": text
            },
            "POWER_AUTOMATE": {
                "text": text,
            }
        }

        return payload.get(webhookType)

    def notify(self):
        webhookUrl = self.get_variable("WEBHOOK_URL")
        message = self.get_variable("MESSAGE")
        headers = {'Content-Type': 'application/json'}
        changelogFile = self.get_variable('FILENAME')
        webhookType = self.get_variable('WEBHOOK_TYPE')
        parsedMessage = markdownify.markdownify(message, heading_style="ATX")

        if not changelogFile:
            payload = self.getPayload(webhookType, parsedMessage)
        else:
            changes = list(keepachangelog.to_raw_dict(os.path.basename(changelogFile)).items())
            tagContent = changes[0][1]['raw']
            tagVersion = "**" + changes[0][1]['version'] + "** \n\n\n\n‌‌"
            parsedTagContent = tagContent.replace('"', '').replace("'", '').replace('### Added', '**Added** \r').replace('### Changed', '\r **Changed**').replace('### Fixed', '\r **Fixed**')
            text = parsedMessage + "\n\n\n\n‌‌ " + tagVersion + parsedTagContent
            payload = self.getPayload(webhookType, text)

        try:
            response = requests.post(
                url=webhookUrl,
                headers=headers,
                json=payload
            )
        except requests.exceptions.Timeout as error:
            message = self.create_message(
                BASE_FAILED_MESSAGE,
                'Request to MS Teams timed out',
                error
            )
            self.fail(message)
        except requests.ConnectionError as error:
            message = self.create_message(
                BASE_FAILED_MESSAGE,
                'Connection Error',
                error
            )
            self.fail(message)

        self.log_info(f"HTTP Response: {response.text}")

        if 200 <= response.status_code <= 299:
            self.success(BASE_SUCCESS_MESSAGE)
        else:
            self.fail(BASE_FAILED_MESSAGE)

    def create_message(self, base_message, error_message, error_text):
        message = '{}: {}{}'.format(
            base_message,
            error_message,
            f': {error_text}'
        )
        return message

    def run(self):
        super().run()
        self.notify()


if __name__ == '__main__':
    with open('/pipe.yml', 'r') as metadata_file:
        metadata = yaml.safe_load(metadata_file.read())
    pipe = TeamsNotifyPipe(schema=schema, pipe_metadata=metadata, check_for_newer_version=True)
    pipe.run()
