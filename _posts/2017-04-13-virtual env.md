---
layout: post
title: virtualenv
category: python
tags: virtualenv, tools
comments: true
---


Let's talk about a must have tool in every python devoloper's toolkit: virtualenv.

When you install a third party package with pip, it is installed system-wide.  Sooner or later it becomes messy managing all the packages and you'll run into issues. What would you do if you need different versions of python interpreter or a different versions of particular package for seperate projects? 

virtualenv solves these problems by creating isolated python environments for each of your projects. 


To understand how virtualenv works, we first need to understand how python searches for modules.
When we import a package, python interpreter searches a list of directories under `sys.path` variable. 


    >>> import sys
    >>> sys.path
    ['', '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python27.zip', 
    '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7', 
    '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/plat-mac', 
    '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-tk', 
    '/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/lib-dynload', 
    '/Library/Python/2.7/site-packages']

The first element in this list is an empty string which denotes current working directory from which python interpreter is started. When you import a package in python code, python interpretor searches these list of directories linearly until a matching package is found or end of list is reached. One important directory in this list is `site-packages`. This is the default directory where third party packages are installed. 



Now let's see how to use virtualenv. First install virtualenv system-wide using `pip install virtualenv`. You may have to use sudo if you are on mac of linux. 
    
    $ pip install virtualenv

Now before starting any project, create a virtual environment for it. `.virtualenvs` is commonly used directory name for storing the virtualenvs. It is better to seperate the actual python code of your project and the virtualenv for it. The virtualenv of the project will contain the  python interpreter and required dependencies and your project directory should contain the python code that you are going to write.

    $ mkdir .virtualenvs

To create a new project called test, run the following command inside .virtualenv directory, `virtualenv test`

    $ virtualenv test
    New python executable in /Users/vshashank/.virtualenvs/test/bin/python
    Installing setuptools, pip, wheel...done.

What virtualenv has done is it created a new directory called test. Installed python inside the test directory and installed other frequently used tools like setuptools, pip, wheel inside the test directory. You can find the python interpreter inside `bin` directory of the new virtualenv.

Now how do we use the environment? 
You need to activate the environment using the activate script inside `bin` directory. On windows you can find this under `Scripts` directory. 

    $ . test/bin/activate
    (test) $

What activate does?
    
* Changes PS1 prompt to indicate the actve virtualenv.
* Saves current environmental variables like PATH
* Change PATH environment variable. bin directory inside the virtualenv is prefixed to PATH variable. So when you run python command, python interpreter in the bin folder of the virtualenv is invoked. 
* sys.path variable is changed to search for modules inside virtualenv first.


On unix or mac, you can run `which python` to check which python interpreter is being used. 

    (test) $ which python 
    /Users/vshashank/dev/.virtualenvs/test/bin/python

You can see that we are using python interpreter installed in bin folder of our virtual environment. 
If you install new third party packages using pip, they will be installed in the site-packages of current virtualenv.

To de-activate the virtual environment just type `deactivate`. deactivate will restore the old environment by changing the PS1, PATH etc back to defualts.

## Summary ##

Now that you understand how virtualenv works. Let's summarize with an example of usual workflow. 
I want to start a new python project called spark. I usually have all my projects under $HOME/dev/ directory. 

First I'd create a virtualenv for my new python project in .virtualenvs directory. Then create a directory called spark under $HOME/dev directory for the actual python code. Then activate the virtualenv before working on my new project. 
    
    $ virtualenv spark
    New python executable in /Users/vshashank/.virtualenvs/spark/bin/python
I   Installing setuptools, pip, wheel...done.
    vshashank-mba:~ vshashank$ . .virtualenvs/spark/bin/activate
    (spark) $ cd dev
    (spark) $ mkdir spark
    (spark) $ python
    Python 2.7.10 (default, Dec 20 2016, 23:53:20)
    >>>
    
There is another cool tool called virtualenvwrapper which makes this workflow slightly more convinient. 
    


