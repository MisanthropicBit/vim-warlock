function toggleTab(event) {
  const tab = $(this)
  const tabId = tab.attr('href')

  // Show the tab container and hide the others
  $('#tab-containers ' + tabId).fadeIn(400).siblings().hide()
  // $('#tab2').fadeIn(400).siblings().hide()

  // Add the active class for this tab and remove it from the others
  tab.parent('div').addClass('active').siblings().removeClass('active')

  event.preventDefault()
}

$(document).ready(function(event) {
  const tabs = document.getElementById('#tabs')

  $('#tabs a').each(function () {
    $(this).on('click', toggleTab)
  })
})
