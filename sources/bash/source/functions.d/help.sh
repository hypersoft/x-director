function --help() {

cat <<EOF

$COMMAND [OPTIONS] FUNCTION [...]

General Purpose, Mutliple Record, File, Expression and Execution: Utility

 ALL EXPRESSIONS, REGULARLY: EXTENDED.

License: MIT
GitHub: https://github.com/hypersoft/x-director

(C) 2018; Triston-Jerard: Taylor;
          Hypersoft-Systems: U.-S.-A.

OPTION FLAGS

 Flags may be combined to produce a compound option. For example:

   $COMMAND -rf catalog 1 -- .

   Lists the real path of files in the current directory.

 --help  Show this help screen
  -h     Show this help screen.

 --get-theatre  Generates a hash-key-list of FUNCTIONS and OPTIONS.

 -r  Convert path record(s) to realpath(s).
 -d  Only print existing directories.
 -f  Only print existing files.
 -p  Only print parent directories.
 -l  Only print links.
 -L  Do not print links.
 -n  Only print file names.

OPTION FLAGS: ENVIRONMENT

  -z  Set Standards Compliant IFS = \$' \t\n'.
  -t  Match the tail/type of records. Uses the RX char: \`\$'
  -h  Match the head/heading of records. Uses the RX char: \`^'

OPTION SETTINGS

 Settings may be combined with flags as a single parameter, IF: it is the last
 OPTION in the single-parameter-set. For example:

   $COMMAND -ti:\.md -f catalog 1 -- .

   Lists all .md files in the current directory.

 -e: FILTER   Perform an exclude match against FILTER(s). Multiple filters may
              be supplied as a single parameter. The shell will expand the
              FILTERS according to IFS (see also OPTIONS: \`-z': and \`-z') for
              control of the shell expansion.

 -i: FILTER   Perform an include match against FILTER(s). Works like \`-e:'.

 -s: TYPE     Perform a sort by TYPE; where TYPE is:

               u for uniqe sort.
               v for version sort.
               n for name sort.
               
               [TYPES cannot be combined as a single parameter to \`-s:']

OPTION SETTINGS: EVIRONMENT
 
 -t: TEXT     Sets the TAIL of all primary expressions to text.
 -h: TEXT     Sets the HEAD of all primary expressions to TEXT.

 -Q: TEXT     Sets the internal expression separator of the subset FUNCTION
              to TEXT. You may never need this option. The default is \$'\1'.
              This feature only affects the subset FUNCTION.

 -q: TEXT     Set regular-expression quoting character to TEXT for internal
              scripts. The default is \`'".

 -z: TEXT     Sets the IFS variable to TEXT. See your shell manual about IFS.

FUNCTIONS

 catalog [NUMBER] -- DIRECTORY [...]
 
   Lists the files in DIRECTOR(IES). If NUMBER is supplied, it limits the
   maximum depth of the search; where 1 means do not traverse any children of
   the DIRECTORY; 2 is children of child DIRECTORY, so on and so forth.

 command [OPTIONS]        Runs the system command with the given options.
 
 directories FILE ...     Lists only the directories in FILE(S).
 files FILE ...           Lists only the file(s) in FILE(S).

 filter [-e] -- MATCH-PATTERN ...

  Searches through stdin line records seeking MATCH-PATTERN(S). If MATCH-PATTERN
  is found it is written to stdout unless the -e option has been specified. If
  the -e option has been specified, all matches are excluded from output.

 names FILE ...           Lists only the name parts of FILE(S).
 parents FILE ...         Lists only the parent-directories of FILE(S).

 links [-e] -- FILE ...   Lists only the links in FILE(S). With \`-e', lists
                          all files which are NOT links.

 mask-match  Reads records from stdin, masking all special matching characters.
             The result of this operation creates a plain-text-match.

 read-parameter-pipe  COMMAND or FUNCTION [OPTIONS]

   Read lines from input and send them as parameters to COMMAND or FUNCTION
   with any OPTIONS.

 write-parameter-pipe  ...  Converts all parameters to line-stream-output.

 trace SOMETHING     Performs a debug trace explaining dependency chain,
                     backwards AND forwards [quantum-filters ;)].
                     
 realpaths FILE ...  List only the realpath(s) of FILE(S).

 key-within-list KEY -- VALUE ...

   Searches through VALUE(S) for KEY. Returns success if literally found. Ready
   made for read-parameter-pipe FUNCTION.

 subset CUT-PATTERN PASTE-TEXT[ CUT-PATTERN PASTE-TEXT[ ...]]

   Searches through stdin line records using CUT-PATTERN and replaces matches
   with PASTE-TEXT. Multiple CUT-PATTERN and PASTE-TEXT expressions may be
   supplied. Use the write-parameter-pipe FUNCTION if stdio is not convenient.

NOTE:

 (1) OPTIONS affect the output of FUNCTIONS.

 (2) OPTIONS are executed in REVERSE-ORDER of command specification; except:
     (1) when an OPTION is not a shortcut to a FUNCTION.
         (1.a) if the OPTION is not a shortcut to a FUNCTION, it is instantly
               applied THROUGH the OPTION or FUNCTION following it in the
               command specification. Which means all environment OPTIONS are
               immediately effective at the beginning of the command following
               it; being of the form: [ENVIRONMENT] OPTION OR FUNCTION.

               [see: the function definitions of the OPTIONS in source code
                     to verify the above form.
                
                  file://$(realpath $0)
               ]

 (3) CAVEAT: using the form -word:parameter, where parameter expands to an empty
     string will cause the parmater parser to grab the next available parameter.
     the only fix for this is a change of syntax. Please use -word= to avoid the
     pitfall unless you provide literal string data. The = operator does not
     apply to options which are separated from their values. Therefore the
     correct usage as mentioned here is a guranteed safeguard for the hazzard.

See: "regex - POSIX.2 regular expressions" within the Linux Programmer's Manual
     for help on expressions (\`man 7 regex').

END $COMMAND --help ##################################################################

$COMMAND [OPTIONS] FUNCTION [...]

General Purpose, Mutliple Record, File, Expression and Execution: Utility

 ALL EXPRESSIONS, REGULARLY: EXTENDED.

License: MIT
GitHub: https://github.com/hypersoft/x-director

                                           (C) 2018; Triston-Jerard: Taylor;
                                                     Hypersoft-Systems: U.-S.-A.

EOF

exit 1;

} >&2;
