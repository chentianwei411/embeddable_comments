document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='autocomplete']")

  // 1.指定url参数
  // 2.指定getValue参数, 获得对应的字段的数据。
  var options = {
    getValue: "name",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    // 设置一个目录，listLocation是显示hash对象对应的key的值
    categories: [
      {
        listLocation: "movies",
        header: "<strong>--Movies--</strong>"
      },
      {
        listLocation: "directors",
        header: "<strong>--Directors--</strong>"
      }
    ],
    // easyAutocomplete提供的事件函数，放在list对象中使用。这里需要用jquery对象。
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url
        console.log(url)
        $input.val("")
        Turbolinks.visit(url)
      }
    }
  }

  requestDelay: 500
  
  $input.easyAutocomplete(options)
})
