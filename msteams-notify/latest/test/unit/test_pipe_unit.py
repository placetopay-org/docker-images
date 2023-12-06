import io
import os
import sys
from unittest import mock
from contextlib import contextmanager

from bitbucket_pipes_toolkit.test import PipeTestCase

from pipe.pipe import TeamsNotifyPipe, schema


TEST_WEBHOOK_URL = "https://msteams-webhook.com"


@contextmanager
def capture_output():
    standard_out = sys.stdout
    try:
        stdout = io.StringIO()
        sys.stdout = stdout
        yield stdout
    finally:
        sys.stdout = standard_out
        sys.stdout.flush()


@mock.patch('requests.post')
@mock.patch.dict(os.environ, {'WEBHOOK_URL': TEST_WEBHOOK_URL, 'MESSAGE': '<b>Hello!</b>', 'WEBHOOK_TYPE': 'POWER_AUTOMATE'})
class MicrosoftTeamsNotifyTestCase(PipeTestCase):

    def test_notify_failed(self, msteams_status_mock):

        msteams_status_mock.return_value.status_code = 400
        msteams_status_mock.return_value.text.return_value = 'invalid'

        with capture_output() as out:
            with self.assertRaises(SystemExit) as exc_context:
                TeamsNotifyPipe(schema=schema).run()
            self.assertEqual(exc_context.exception.code, 1)

        self.assertRegex(out.getvalue(), rf"✖ Notification failed.")

    def test_notify_succeeded(self, msteams_status_mock):

        msteams_status_mock.return_value.status_code = 200
        msteams_status_mock.return_value.text.return_value = 'ok'

        with capture_output() as out:
            TeamsNotifyPipe(schema=schema).run()

        self.assertRegex(out.getvalue(), rf"✔ Notification successful.")
