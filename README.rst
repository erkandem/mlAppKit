
mlAppKit
===========================
*build better GUIs more efficiently*

--------------------------------

:Author: Erkan Demiralay
:Email:   `erkan@erkan.io <mailto:ed@erkan.io>`_
:Web:    `erkandem.github.io/ <https://https://erkandem.github.io/>`_
:GitHub: `erkandem/mlAppKit <https://github.com/erkandem/mlAppKit>`_

:Requirement: MatLab R2016b or later

Getting Started
===================

Project Summary
---------------------

Creating GUIs with ``MatLab`` has become very easy with ``App Designer``.
However, these GUIs usually stay either quite simple or
get **too big to maintain**. Leverage your work with ``App Designer`` by using **mlAppKit**
which joins multiple standalone apps to one production app. Keep
your standalone apps small and easy to maintain. Create more complex apps
more professionaly without loosing the benefits of the drag and drop experience
of ``App Designer`` once you go offroad by editing the underlying ``classdef`` code.



Installing Development Version
-------------------------------

Use the ``git clone`` or download the zipped repository and run the :ref:`make` script.
You're ready to modify files as you like (boilerplate included)

.. code:: bash

   $ git clone https://github.com/erkandem/mlAppKit.git


.. code:: matlab

   >> make()


Installing the User Version
-------------------------------
The user version assumes that you want to package your applications instead
of working on the tool itself.
Download the `latest build <https://github.com/erkandem/mlAppKit/releases/latest/download/mlappkit_static_bundle.zip>`_

The unzipped folder includes a setup script which will place
frequently used functions into a directory within your ``userpath`` and
add the the directory to your MATLAB path permanently.
You can modify the installation path during setup.

.. code:: matlab

   >> mlappkit_setup()

After running ``mlappkit_setup`` you can access a boilerplate generator.
The :ref:`mlappkit_quickstart` command is inspired by sphinx_quickstart.
It will launch a dialog and unzip a boilerplate project.

.. code:: matlab

   >> target_dir = pwd();
   >> project_name   = 'hello_world';
   >> mlappkit_quickstart(target_dir, project_name);


``cd`` into the directory and run the ``make`` command.

.. code:: matlab
   
   >> cd hello_world
   >> make()

The next step is to develop your app of apps or reshape existing code into
what you want. This will be discussed in the next paragraph.

You can easily package a your final app using the :ref:`package_app` function.
This command will extract all m-files and static files into a single folder
which you can redistribute.

.. code:: matlab
   
   >> package_app()

   
Adding Your Own Apps
^^^^^^^^^^^^^^^^^^^^
Currently, migrating to mlAppKit boils down to:
   i. preparing your apps (i.e. make them recognizable)
   ii. adding your app to the startup function
   iii. creating a menu entry within ``host_app``

**i. prepare your apps**

#. create a new folder for each group of apps within the project root directory and
   place your ``.mlapp`` files inside it

#. open each of your apps in MatLab App Designer
   and create a new ``uipanel``.

#. Rename the new ``uipanel`` to ``main_Panel``
   and copy paste your app content into this ``uipanel``


**ii Connecting Your App to host_app**

The app will later be started with either :ref:`app_lauch`
Open up the :ref:`ext_start_up` function and edit two sections.

.. code:: bash

   .
   └── functions  
         └── start_up
               └── ext_start_up.m
   

#. Change ``<yourApp>`` with  the name of your ``.mlapp`` file.
   ``<yourGroup>`` is used to keep it the namespace tidy.
    I'd recommend to match the name of the of folder previously selected.

.. code:: matlab

   app.plugins.<yourGroup>.<yourApp> =  <yourApp>(app.(f));


#. assign a Tag to each individual app. I'd recommend to simply use the name of the app.
   Afterwards, save and exit.

.. code:: matlab

   app.plugins.<yourGroup>.<yourApp>.main_Panel.Tag = '<yourApp>';


**iii. Creating a Menu Entry for you App**

Open the ``host_app.mlapp`` from ``App Designer``.
Add a menu entry and add create a new ``Menu Selected Callback``.
Now change from the design view to the code view in App Designer
and find the new menuSelected callback. App Designer should take you there
after adding the callback.

Add a call to the :ref:`panel_visibility_switch` with the handle of
the host_app and a the tag name which you assigned in the previous step into
the callback.

.. code:: bash

   .
   └── host
        └── host_app.mlapp


.. code:: matlab

        function yourAppMenuSelected(app, event)
           target_tag = 'yourApp';
           panel_visibility_switch(app, target_tag)
        end


Your Done! Call the :ref:`make` function in the project root directory.
This will start a cascade of code extraction, modification and creation.

.. code:: bash

   >> make()


The expected outcome is that the class definition code of all your ``.mlapp``
files will be extracted and slightly modified to play nice with each other.

Since ``MatLab`` has one global namespace the :ref:`make` command will create functions
to add and remove project specific functions to the ``MatLab path`` defined in ``pathdef.m``.
They will be removed from the ``MatLab path`` if you close the IDE (recommended).


Support, Feature Requests, Suggestions
-------------------------------------------

If you need more info check out the documentation.
Generally, take a look at the `Issues Section <https://github.com/erkandem/mlAppKit/issues>`_

Write me an email. I'll try to get back to you as soon as possible. Especially during the
first months after publication.

Contributions
-------------
MatLab doesn't have a PEP8. That doesn't mean that PEP8 guide can't be applied
to MatLab code with some adjustments.


Final Notes
---------------

The project is licensed under terms of the MIT :ref:`License`.


