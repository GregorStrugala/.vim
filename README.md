Being a highly customizable text editor, Vim has a configuration file—the
`.vimrc`—that can quickly become quite long and very user-specific.
It is thus a good idea to put it under version control.
The problem is that the `.vimrc` file has to be located in the `~`
folder—on Linux systems, that is.
Obviously, this directory shouldn't be a Git repository,
since it has so many files that don't need version control.

A good way to put it under version control without including
all the rest of the `~` directory is simply to move it elsewhere
and make a soft link in `~`.
Where to put it then ?
Well, the `.vim` directory is a logical location to store the `.vimrc`.
And, as long as all the plugin files are not put under version control¹,
the `.vim` directory makes an easily manageable Git repo.


### How to achieve it concretely ?

1. First, move the `.vimrc` to the `.vim` directory.
```bash
mv .vimrc .vim/.vimrc
```

2. Then, create a symbolic link in `~/home`.
```bash
ln -s .vim/.vimrc .vimrc
```

3. Finally, go into into the `~/.vim` directory and initialize it.
```bash
cd .vim
git init
```

Do not forget to exclude the relevant directories from the repo
with the [`.gitignore`](.gitignore) !

---
¹That would be redundant anyway since plugins are already put under
version control.
To ignore them during the staging process, simply add the relevant
directory—typically `~/.vim/plugged/` to the [`.gitignore`](.gitignore).
