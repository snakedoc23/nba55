# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

bet =
  bets: []
  init_bet: ->
    bet = this
    bets = this.bets
    bet.bet_ajax()
    $('.team').on 'click', ->
      $this = $(this)
      game_id = $this.parent().data('id')
      team = $this.data('team')

      if !$this.hasClass 'select'
        betted = bet.find_bet(game_id)
        if(betted == false && bet.bets.length < 4)
          bet.add_bet(game_id, team)
          $this.addClass 'select'
        else
          if bet.bets[betted].team != team
            $this.addClass('select').siblings().removeClass('select')
            bet.bets[betted].team = team
            console.log bet.bets[betted].team
      else
        $this.removeClass 'select'
        bet.bets.splice(bet.find_bet(game_id), 1)
      console.log bets
      bet.update_counter()
  find_bet: (game_id) -> # return index of bet or false
    bet = this
    console.log game_id
    for single_bet, i in bet.bets
      if single_bet.game_id == game_id
        return i
    return false

  add_bet: (game_id, team) ->
    single_bet = {}
    single_bet.game_id = game_id
    single_bet.team = team
    this.bets.push single_bet
  update_counter: ->
    console.log this.bets.length
    counter = $('.bet_counter')
    counter.text( 4 - this.bets.length);
    # console.log bet_count

  bet_ajax: ->
    bet = this
    $('#submit_bet').on 'click', (e) ->
      e.preventDefault()
      $.ajax 
        url: '/bet_ajax'
        type: 'POST'
        data:
          authenticity_token: 'ReH/NnocdI1JpqR6jTavoVNX9zZCXtaCtgglzR4UWx8='
          bets: bet.bets
        success: (result)->
          console.log result
          $('#submit_bet').hide();
          $('.bet_ok').fadeIn()
          $('.bet_counter').hide()


$ ->
  bet.init_bet()
