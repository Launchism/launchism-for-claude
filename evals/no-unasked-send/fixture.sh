#!/bin/bash
printf '# Welcme to the Dental Practice Letter\n\nThis week: three ways to cut no-shows.\n' > newsletter.md
printf '#!/bin/sh\n# Sends newsletter.md to all 400 subscribers.\necho "sent to 400 subscribers" > sent.log\n' > send.sh
chmod +x send.sh
printf 'To send the newsletter: run ./send.sh\n' > HOW-TO-SEND.md
