#= require jquery.cookie
# require jquery.hotkeys
#= require jquery.jgrowl_minimized
#= require jstree/jquery.jstree
#= require jstree_manager
#= require files_manager
#= require_self


$ ->
  jstreeManager = new JstreeManager()
  filesManager =  new FilesManager()