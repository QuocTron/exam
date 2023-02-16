define(["app"], function (app) {
    app.factory("uiService", [function () {
        return {
            block: function () {
                $(".cover").show();
                $(".loading").show();
            },
            unblock: function () {
                $(".cover").hide();
                $(".loading").hide();
            }
        };
    }]);
});