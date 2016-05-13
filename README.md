Its time to make some open source contribution again. :-)

Sublime 3 is still my most favorate script source code editor, Recently I am working on the project that requires to use freebsd as daily development os. and by default if you have installed linux-sublime3 by pkg command. it will not works, and even not show any error messages. 

that is because sublime3 is ported from linux, and by default installation of freebsd is not fully enabled linux compatibile settings.

so this script will help you to fix the issue.

Just simple check out the project and run below script, you will see it get fixed and the lovely sublime3 will popup now.
it also automatic fixed the system configuration. so next time you will not need to run this script again.

```sh
sudo ./sublime3-fix.sh
```

After it get fixed, you can safety delete my script.