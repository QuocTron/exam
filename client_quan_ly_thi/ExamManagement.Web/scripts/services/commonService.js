define(["app"], app => {
    app.factory("commonService", ["$http", "utility", ($http, utility) => {
        var serviceurl = utility.baseAddress;
        var apiurl = utility.baseAddress + 'api/common';
        return {
            addModelReviewQuestionSheet: () => {
                return $http.get(`http://localhost:60931/views/shared/ReviewQuestionSheet.html`);
            },

            reviewQuestionSheet: (questionSheetId) => {
                return $http.get(`${apiurl}/reviewQuestionSheet/${questionSheetId}`);
            }
        };
    }]);
});