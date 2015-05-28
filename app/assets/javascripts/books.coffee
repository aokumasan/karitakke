# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', -> # turbolinks対策
  ### 郵便番号入力フォーム：数値のみの入力 ###
  $('#book_isbn').keydown ->
    presskey = String.fromCharCode(event.keyCode);
    event.returnValue = /[0-9\b\t\n]/.test(presskey) # 入力受付キーを正規表現で指定

  ### 住所取得ボタン：Ajaxで住所取得 ###
  $('#info_search_button').click ->
    isbncode = $('#book_isbn').val()
    $.ajax
      async:    true                             # true:非同期通信
      url:      "/books/new/get_info/"
      type:     "GET"
      data:     {isbn: isbncode}
      dataType: "json"
      context:  this
      error: (jqXHR, textStatus, errorThrown) -> # 通信/サーバエラーなど
        $("#postalcode-result").css("color","#ff0000").html(errorThrown)
      success:  (data, textStatus, jqXHR) ->
        if data?                                 # 対象あり
          $("#book_title").val(data.Title) # 県名index更新
          $("#book_author").val(data.Author) # 県名index更新
          $("#book_manufacturer").val(data.Manufacturer) # 県名index更新
          $("#book_publication_date").val(data.Publication_Date) # 県名index更新
        else                                     # 対象なし
          $("#postalcode-result").css("color","#ff0000").html("未登録の郵便番号
です。")

  ### MSGのリセット ###
  $('.address').change -> $("#postalcode-result").html("")
