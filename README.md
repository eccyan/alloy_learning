# alloy_learning

## Install

Install alloytools
[AlloyTools/org\.alloytools\.alloy: Alloy is a language for describing structures and a tool for exploring them\. It has been used in a wide range of applications from finding holes in security mechanisms to designing telephone switching networks\. This repository contains the code for the tool\.](https://github.com/AlloyTools/org.alloytools.alloy)

```sh
$ git clone git@github.com:AlloyTools/org.alloytools.alloy.git
$ git clone git@github.com:AlloyTools/org.alloytools.alloy.git
$ cd org.alloytools.alloy
$ ./gradlew build
```

## Run CLI

```
$ env ALLOY_DIST_JAR=<YOUR_ALLOY_JAR_PATH> ./cli src/*
Parsing+Typechecking... ok
Executing Run emptyDir for 7...
   2586 vars. 70 primary vars. 3815 clauses.
```
