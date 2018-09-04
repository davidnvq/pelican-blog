Title: Automation and Make
Slug: automation-and-make
Date: 2018-08-27 16:15:24
Tags: Make, Automation, TUTORIAL
Author: Quang Nguyen
Category: tutorial
TopPost: no

# Automation and Make: Running Make

## Key Points




Lesson                        | Summary
------------------------------|------------------------------
[Introduction](https://swcarpentry.github.io/make-novice/reference.html)                  | &bull; Make allows us to specify what depends on what and how to update things that are out of date.
[Makefiles][]                     | &bull; Use `#` for comments in Makefiles.<br/> &bull; Write rules as `target`: `dependencies`. <br/> &bull; Specify update actions in a tab-indented block under the rule. <br/> &bull; Use `.PHONY` to mark targets that don’t correspond to files.
Automatic Variables           | &bull; Use $@ to refer to the target of the current rule. <br/> &bull; Use $^ to refer to the dependencies of the current rule. <br/> &bull; Use $< to refer to the first dependency of the current rule.
Dependencies on Data and Code | &bull; Make results depend on processing scripts as well as data files. <br/>  &bull; Dependencies are transitive: if A depends on B and B depends on C, a change to C will indirectly trigger an update
Pattern Rules                 | &bull; Use the wildcard % as a placeholder in targets and dependencies. <br/> &bull; Use the special variable $* to refer to matching sets of files in actions.
Variables                     | &bull; Define variables by assigning values to names. <br/> &bull; Reference variables using $(...).


w