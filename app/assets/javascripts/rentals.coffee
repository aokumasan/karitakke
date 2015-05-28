# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', -> # turbolinks対策
  ### ISBN入力フォーム：数値のみの入力 ###
  $('#book_code').keydown ->
    presskey = String.fromCharCode(event.keyCode);
    event.returnValue = /[0-9\b\t\n]/.test(presskey) # 入力受付キーを正規表現で指定

  ### 本の情報取得ボタン：Ajaxで情報取得 ###
  $('#search_button').click ->
    code = $('#book_code').val()
    $.ajax
      async:    true                             # true:非同期通信
      url:      "/rentals/new/search_book/"
      type:     "GET"
      data:     {code: code}
      dataType: "json"
      context:  this
      error: (jqXHR, textStatus, errorThrown) -> # 通信/サーバエラーなど
        $("#error_msg").css("color","#ff0000").html(errorThrown)
      success:  (data, textStatus, jqXHR) ->
        if data?                                 # 対象あり
          $("#book_title").val(data.Title) # タイトル更新
          $("#book_author").val(data.Author) # 著者名更新
          $("#book_manufacturer").val(data.Manufacturer) # 出版社更新
          $("#book_id").val(data.Id) # ID更新
          $('#rental_button').attr('disabled', false) # 貸出ボタンの有効化
          $('#rental_button').removeAttr('disabled')
          $('#return_button').attr('disabled', false) # 貸出ボタンの有効化
          $('#return_button').removeAttr('disabled')
        else                                     # 対象なし
          $("#error_msg").css("color","#ff0000").html("未登録の本です。")

  ### MSGのリセット ###
  $('#book_code').change  ->
    $("#error_msg").html("")
    $("#title").val("")
    $("#author").val("")
    $("#manufacturer").val("")
    $('#rental_button').attr('disabled', true);
