# curlftpfs backup script

## Dependencies

- `curlftpfs`
- `tar`

## Usage

- Copy `example.sh` to your own script (i.e. `cp example.sh mybackupscript.sh`)
- Replace every variables with your own configuration
- Make sure that your `MOUNT` path exists on your server before executing the script
- Add execution flag to your script `chmod +x mybackupscript.sh`
- Test it manually `sh mybackupscript.sh`
- if everything is OK, add your script to your Crontab to execute it every nights