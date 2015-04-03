#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require jquery.validate
#= require jquery.timeago
#= require hepte
#= require_tree ./plugins

$(document).on 'page:update', ->
  $("time[data-behaviors~=timeago]").timeago()

Turbolinks.enableProgressBar();