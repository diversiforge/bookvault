$(function() {
    var App = {
        init : function() {
            Quagga.init(this.state, function(err) {
                if (err) {
                    console.log(err);
                    return;
                }
                App.attachListeners();
                Quagga.start();
            });
        },
        attachListeners: function() {
            var self = this;

            $(".controls").on("click", "button.stop", function(e) {
                e.preventDefault();
              Quagga.stop();
            });

            $(".controls .reader-config-group").on("change", "input, select", function(e) {
                e.preventDefault();
                var $target = $(e.target),
                    value = $target.attr("type") === "checkbox" ? $target.prop("checked") : $target.val(),
                    name = $target.attr("name"),
                    state = self._convertNameToState(name);

                console.log("Value of "+ state + " changed to " + value);
                self.setState(state, value);
            });
        },
        _accessByPath: function(obj, path, val) {
            var parts = path.split('.'),
                depth = parts.length,
                setter = (typeof val !== "undefined") ? true : false;

            return parts.reduce(function(o, key, i) {
                if (setter && (i + 1) === depth) {
                    o[key] = val;
                }
                return key in o ? o[key] : {};
            }, obj);
        },
        _convertNameToState: function(name) {
            return name.replace("_", ".").split("-").reduce(function(result, value) {
                return result + value.charAt(0).toUpperCase() + value.substring(1);
            });
        },
        detachListeners: function() {
            $(".controls").off("click", "button.stop");
            $(".controls .reader-config-group").off("change", "input, select");
        },
        setState: function(path, value) {
            var self = this;

            if (typeof self._accessByPath(self.inputMapper, path) === "function") {
                value = self._accessByPath(self.inputMapper, path)(value);
            }

            self._accessByPath(self.state, path, value);

            console.log(JSON.stringify(self.state));
            App.detachListeners();
            Quagga.stop();
            App.init();
        },
        inputMapper: {
            inputStream: {
                constraints: function(value){
                    var values = value.split('x');
                    return {
                        width: parseInt(values[0]),
                        height: parseInt(values[1]),
                        facing: "environment"
                    }
                }
            },
            numOfWorkers: function() {
                if (navigator.hardwareConcurrency === "undefined") {
                  return 2; // hopefully sane default until we get hardwareConcurrency everywhere
                } else {
                  return navigator.hardwareConcurrency;
                }
            },
            decoder: {
                readers: ['ean_reader'],
                multiple: false
            }
        },
        state: {
            inputStream: {
                type : "LiveStream",
                constraints: {
                    width: 800,
                    height: 600,
                    facing: "environment" // or user
                }
            },
            locator: {
                patchSize: "medium",
                halfSample: true
            },
            numOfWorkers: 2,
            decoder: {
                readers : ["ean_reader"]
            },
            locate: true
        },
        lastResult : null
    };

    App.init();

    Quagga.onDetected(function(result) {
      Quagga.stop();
      //$('#scanner').hide(400);
      var code = result.codeResult.code;

      if (App.lastResult !== code) {
        App.lastResult = code;
        var $node = null, canvas = Quagga.canvas.dom.image;

        //$node = $('<li><div class="thumbnail"><div class="imgWrapper"><img /></div><div class="caption"><h4 class="code"></h4></divZ></div></div></li>');
        //$node.find("img").attr("src", canvas.toDataURL());
        //$node.find("h4.code").html(code);
        $("#result_strip ul.thumbnails").prepend($node);
        $('#book_isbn13').val(code);
        }
    });
});
