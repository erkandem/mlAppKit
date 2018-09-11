
mlAppKit
===========================
*build better GUIs more efficiently*

--------------------------------

:Author: Erkan Demiralay
:Email:   `ed@m2py.com <mailto:ed@m2py.com>`_
:Web:    `erkan.io <https://erkan.io>`_
:GitHub: `erkandem/mlAppKit <https://github.com/erkandem/mlAppKit>`_

:Requirement: MATLAB R 2016b or later

Getting Started
===================

Summary
---------------------

Creating GUIs with *MATLAB* has become very easy with *App Designer*.
However, these GUIs usually stay either quite simple or
get too big to maintain. Leverage your work with *App Designer* by using **mlAppKit** 
which joins multiple standalone apps to one production app. This way you can keep 
your standalone apps small and easy to maintain. Create more complex Apps 
more professionaly  without loosing the benefits of the drag and drop experience 
of *App Designer* once you go offroad by editing the underlying classdef code.


Installing and Usage
----------------------

Use the git clone command or download the zipped repository and run the :ref:`mlappkit_setup`

.. code:: matlab

   >> mlappkit_setup()


The :ref:`mlappkit_quickstart` command will launch a dialog to clone
a boilerplate

.. code:: matlab
   
   >> target_dir = pwd();
   >> prj_name   = 'helloWorld' 
   >> mlappkit_quickstart( target_dir , prj_name )

`CD`   into the directory and run the make command.

.. code:: matlab
   
   >> cd helloWorld
   >> make()


   
adding your own app
^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If you already have an app:

   #. Create a new folder within the project root directory and
   #. Place your `.mlapp` file inside it
 

**I Preparing Your App**
   
   #. open your app in MATLAB App Designer
   #. Create a new `uipanel` and rename it to **main_Panel**
   #. copy paste your content into this  container


**II Connecting Your App**

Open up the :ref:`ext_start_up` and edit two sections

.. code:: bash

   .
   └── functions  
         └── start_up
               └── ext_start_up.m 
   
.. code:: matlab
   
   % 1. Change `yourApp` with  the name of your `.mlapp` file.
   % `yourGroup` is used for keep it tidy and is optional
   app.plugins.yourGroup.yourApp        =  yourApp(app.(f));

   % 2. assign a tag to each individual app ( simply use its appname e.g.)
   app.plugins.yourGroup.yourApp.main_Panel.Tag           = 'yourApp';

   % 3. Save And Exit

   
**III Creating a Menu Enty for you App**

Open the `host_app` from App Designer
   
.. code:: bash

   .
   └── host
        └── host_app.mlapp
   

Add a menu item and a corresponding `Menu Selected Callback`

.. code:: matlab 

   % Menu selected function: yourAppMenu
       function yourAppMenuSelected(app, event)
          target_tag='yourApp';
          panel_visibility_switch(app,target_tag)
       end

Hit :ref:`make` again and  its done.	
   
.. code:: bash
   
   >> make()



Support, Feature Requests, Suggestions
-------------------------------------------

If you need more info intel check out the  documentation.
Generally, take a look at the `Issues Section <https://github.com/erkandem/mlAppKit/issues>`_


:Commercial: contact-
:Individuals: Community support


Final Notes
---------------

The project is licensed with the MIT :ref:`License` .

If you're interested in :ref:`Contributing` 
