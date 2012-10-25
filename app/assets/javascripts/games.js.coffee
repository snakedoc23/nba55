# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  add_bet()


add_bet = ->
  $('.team').on 'click', ->
    $this = $(this)
    game_id = $this.parent().data('id')
    team = $this.data('team')


# $.ajax 
# 	url: '/bet_ajax'
# 	type: 'POST'
# 	data:
# 		authenticity_token: 'ReH/NnocdI1JpqR6jTavoVNX9zZCXtaCtgglzR4UWx8='
# 		game_id: 9
# 		team: 'a'
# 	success: (result)->
# 		console.log result