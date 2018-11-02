# Hypersoft X Director

General Purpose, Mutliple Record, File, Expression and Execution: Utility

    ALL EXPRESSIONS, REGULARLY: EXTENDED.

HELP:
```sh
bin/xd --help
```

\< "I have a regular expression".

\> "Are they regular or irregular"?

\< "I don't know, I think they are extended".

--------------------------------------------------------------------------------

"Having two kinds of REs is a botch." -- kernel.org (`man 7 regex`)

"So is having a shitload of directories for a single target." -- A Smart Ass

Try this one:

```sh
printf -- '-L%s\n' $(xd -s:u -prti:nspr4\.so catalog 1 -- /lib /usr/lib /usr/local/lib)
-L/usr/lib
-L/usr/local/lib
```
