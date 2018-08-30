Functions
=========

This sections is mostly autodocumented  "views"
These core functions are mostly used to build the application class files.
If you are more interested how it generally works take a look at the readme or the code itself

But a flow schema or .gif animation would really be nice here...


.. warning:: Always clone a fresh set from git for a new project.
             Pull requests welcome =)

.. toctree::
   :maxdepth: 2
   :caption: Contents:
   
   functions_index

run
^^^
will initiate the conversion of .mlapp to m and run the app from the m.files obtained

.. todo:: automate the removal of paths associated with the application on close


panel_visibility
^^^^^^^^^^^^^^^^


.. automodule:: functions.panel_visibility
.. autofunction:: panel_visibility_switch

mlapp_to_m
^^^^^^^^^^

.. automodule:: functions.building
.. autofunction:: mlapp_to_m


helper_f
^^^^^^^^
this group of function changes some strings in the obtained m-file
While all of them could be placed in to one single function I prefered to keep them in seperate files.
The idea is to provide plug and play coding style

uif_createComponents_switcher
"""""""""""""""""""""""""""""

.. automodule:: functions.building
.. autofunction:: uif_createComponents_switcher

uif_create_commenter
""""""""""""""""""""

.. autofunction:: uif_create_commenter

uif_panel_paramater_switcher
""""""""""""""""""""""""""""

.. autofunction:: uif_panel_paramater_switcher

uif_commenter
"""""""""""""
Also you may insert any text 

.. autofunction:: uif_commenter



app_launch
^^^^^^^^^^

.. autofunction:: app_launch


addPath_creator
^^^^^^^^^^^^^^^

.. warning:: automatically created. any changes will be discarded if the :func:`run` is executed

.. autofunction:: addPath_creator


conversion_func_generator
^^^^^^^^^^^^^^^^^^^^^^^^^


.. autofunction:: conversion_func_generator

conversion_launcher
^^^^^^^^^^^^^^^^^^^

.. warning:: automatically created. any changes will be discarded if the :func:`run` is executed


.. automodule:: functions.auto_generated
.. autofunction:: conversion_launcher


builder_addPath
^^^^^^^^^^^^^^^


.. automodule:: functions.auto_generated
.. autofunction:: builder_addPath


mignore_reader
^^^^^^^^^^^^^^

.. automodule:: functions.building
.. autofunction:: mignore_reader




add_subfolder
^^^^^^^^^^^^^^

.. automodule:: functions.building
.. autofunction:: add_subfolder




levelOneDirQuery
^^^^^^^^^^^^^^^^^^^^^^

.. automodule:: functions.building
.. autofunction:: levelOneDirQuery
