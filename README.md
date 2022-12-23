# archive encrypt

<img align="right" src="./7z-icon.png">

> :warning: **None of the authors, contributors, administrators, or anyone else connected with this repo, in any way whatsoever, can be responsible for a loss of data or a damage that could be done to it.**: Your data is your data.

[![7z Official](http://inch-ci.org/github/dwyl/hapi-auth-jwt2.svg?branch=master)](https://www.7-zip.org/)

A shell script written to be able to create enncrypted (or not) archive with
the maximum level in order to save storage space.

You will have to use it as is with some arguments (files or folders). It will
use autocompletion if it is set up in your terminal. 

```bash
   ./archive.sh ../file1 /home/file2 ../Folder1/ /home/Folder2
```
Actually, 7z uses the same password to encrypt both the archive header and the
actual file content.  With the command-line argument -mhe=on (the default is
off), you can choose to encrypt the header when using 7z to produce an
encrypted archive.  Whether or not you encrypt the file header, the actual file
content is always encrypted as long as you enter a password.

In both encrypted and unencrypted archives, 7z (as well as zip and rar) uses
file headers just to make it quick and easy to browse through the files and
directories that are contained within.  Due to a long history, tar does not
contain a file list like that.

When it comes to encryption, 7z is secure enough (as long as you choose a good
password).  AES-256, which is secure, is the encryption method used by 7z.
Since 7z is open source, its security cannot be compromised by either
intentional or innocent security issues.

Keep in mind that your 7z archive is encrypted using a password.  That implies
that if someone had your 7z file, he could test each potential password one at
a time until he discovered your password.  Choosing a strong password would
therefore be your best option (a passphrase is a good choice because it is long
enough and easy to remember).
