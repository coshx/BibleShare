$ ->
  $("#private_checkbox").click ->
    if $(this).is(":checked")
      $("#private_members")[0].style.visibility = 'visible'
      $("#private_members")[0].style.height = 'auto'
    else
      $("#private_members")[0].style.visibility = 'hidden'
      $("#private_members")[0].style.height = '0px'

  $("#add_button").click ->
    select_div = $("#select_div")[0]
    new_div = document.createElement('div')
    new_div.innerHTML = select_div.innerHTML
    members_div = $("#members_div")[0]
    $(members_div).append(new_div)


