class @JstreeManager
  constructor: ->
    @tree = $("#jsTree")
    @buildTree()
    @tree

  buildTree: ->
    @tree.jstree(
      plugins: ["themes", "json_data", "ui", "crrm", "cookies", "dnd", "search", "types", "contextmenu"]
      themes:
        url: "/assets/jstree/themes/apple/style.css"
      json_data:
        ajax:
          url: "/refinery/themes/list"
          type: "POST"
          data: (n) ->
            fullpath: (if n.attr then n.attr("fullpath") else "")
      search:
        ajax:
          url: "/refinery/themes/search"
          data: (str) ->
            search_str: str
      types:
        max_depth: -2
        max_children: -2
        valid_children: ["drive"]
        types:
          default:
            valid_children: "none"
            icon:
              image: "/assets/jstree/file.png"
          folder:
            valid_children: ["default", "folder"]
            icon:
              image: "/assets/jstree/folder.png"
          drive:
            valid_children: ["default", "folder"]
            icon:
              image: "/assets/jstree/root.png"
            start_drag: false
            move_node: false
            delete_node: false
            remove: false
    ).bind("select_node.jstree", (e, data) ->
      if data.rslt.obj.attr("rel") is "default"
        $.ajax
          async: false
          type: "POST"
          url: "/refinery/themes/file"
          beforeSend: (request) ->

          data:
            fullpath: data.rslt.obj.attr("fullpath")

          success: (result) ->
            if result
              $("#file-content").html result
              FilesManager.initHandlers()
              $.jGrowl data.rslt.obj.attr("fullpath") + " was loaded.",
                life: 5000
            else
              $.jGrowl result.notice,
                life: 5000


    ).bind("create.jstree", (e, data) ->
      $.post "/refinery/themes/add",
        fullpath: data.rslt.parent.attr("fullpath")
        title: data.rslt.name
        type: data.rslt.obj.attr("rel"),
        (result) ->
          if result.status
            $(data.rslt.obj).attr "fullpath", result.fullpath
            $("#jsTree").jstree "rename_node", $(data.rslt.obj), result.node_name
            $.jGrowl result.notice,
              life: 5000
          else
            $.jstree.rollback data.rlbk
            $.jGrowl result.notice,
              life: 5000


    ).bind("remove.jstree", (e, data) ->
      if (confirm("Are you sure?"))
        $.ajax
          async: false
          type: "POST"
          url: "/refinery/themes/delete"
          data:
            fullpath: data.rslt.obj.attr("fullpath")
            type: data.rslt.obj.attr("rel")

          success: (result) ->
            if result.status
              data.inst.refresh()
              $.jGrowl result.notice,
                life: 5000
            else
              $.jstree.rollback data.rlbk
              $.jGrowl result.notice,
                life: 5000
      else
        $.jstree.rollback data.rlbk

    ).bind("rename.jstree", (e, data) ->
      $.ajax
        async: true
        type: "POST"
        url: "/refinery/themes/rename"
        data:
          fullpath: data.rslt.obj.attr("fullpath")
          new_name: data.rslt.new_name
          type: data.rslt.obj.attr("rel")

        success: (result) ->
          if result.status
            $(data.rslt.obj).attr "fullpath", result.fullpath
            $("#jsTree").jstree "rename_node", $(data.rslt.obj), result.node_name
            $.jGrowl result.notice,
              life: 5000

          else
            $.jstree.rollback data.rlbk
            $.jGrowl result.notice,
              life: 5000


    ).bind "move_node.jstree", (e, data) ->
      data.rslt.o.each (i) ->
        $.ajax
          async: false
          type: "POST"
          url: "/refinery/themes/move"
          data:
            fullpath: $(this).attr("fullpath")
            ref: data.rslt.np.attr("fullpath")
            title: data.rslt.name
            copy: (if data.rslt.cy then 1 else 0)

          success: (result) ->
            unless result.status
              $.jstree.rollback data.rlbk
            else
              $(data.rslt.oc).attr "fullpath", "node_" + result.fullpath
              data.inst.refresh data.inst._get_parent(data.rslt.oc)  if data.rslt.cy and $(data.rslt.oc).children("UL").length

