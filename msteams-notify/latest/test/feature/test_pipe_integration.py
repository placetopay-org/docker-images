import os

from bitbucket_pipes_toolkit.test import PipeTestCase
from dotenv import load_dotenv


class TeamsNotifyPipe(PipeTestCase):

    load_dotenv()
    WEBHOOK_URL = os.getenv("WEBHOOK_URL")

    def test_default_success(self):
        result = self.run_container(environment={
            "WEBHOOK_URL": self.WEBHOOK_URL,
            "MESSAGE": "Pipelines is awesome!",
            "WEBHOOK_TYPE": "INCOMING_WEBHOOK"
        })

        self.assertRegex(result, rf'✔ Notification successful.')

    def test_double_quotes_in_message_success(self):
        result = self.run_container(environment={
            "WEBHOOK_URL": self.WEBHOOK_URL,
            "MESSAGE": '"Pipelines is awesome!"',
            "WEBHOOK_TYPE": "INCOMING_WEBHOOK"
        })

        self.assertRegex(result, rf'✔ Notification successful.')

    def test_default_failed(self):
        BAD_WEBHOOK_URL = "https://google.com/"

        result = self.run_container(environment={
            "WEBHOOK_URL": BAD_WEBHOOK_URL,
            "MESSAGE": "Pipelines is awesome!",
            "WEBHOOK_TYPE": "INCOMING_WEBHOOK"
        })

        self.assertRegex(result, rf'✖ Notification failed.')

    def test_it_can_send_changelog_file(self):
        result = self.run_container(environment={
            "WEBHOOK_URL": self.WEBHOOK_URL,
            "MESSAGE": "Pipelines is awesome!",
            "FILENAME": "../../CHANGELOG.md",
            "WEBHOOK_TYPE": "INCOMING_WEBHOOK"
        })

        self.assertRegex(result, rf'✔ Notification successful.')
