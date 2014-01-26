function loadSectionList() {
    $("section#list").animate({
        'left': '0%'
    }, 750);
    $("section#form").animate({
        'left': '100%'
    }, 750);
}

function loadSectionForm() {
    $("section#form").animate({
        'left': '0%'
    }, 750);
    $("section#list").animate({
        'left': '-100%'
    }, 750);
}



var ProductViewModel = function () {
    //Make the self as 'this' reference
    var self = this;
    //Declare observable which will be bind with UI 
    self.pid = ko.observable("0");
    self.psku = ko.observable("0");
    self.pname = ko.observable("");
    self.pcategory = ko.observable("");
    self.pbrand = ko.observable("");
    self.pmodel = ko.observable("");
    self.pserial = ko.observable("");
    self.pIMEI1 = ko.observable("");
    self.pIMEI2 = ko.observable("");
    self.pbarcode = ko.observable("");

    self.pcost = ko.observable("");
    self.punit = ko.observable("");
    self.pquantity = ko.observable("");

    self.ptest = ko.observable(false);
    self.gtest = ko.observable(true);

    self.stest = ko.observable(false);
    self.utest = ko.observable(false);

    //The Object which stored data entered in the observables
    var product = {
        productId: self.pid,
        sku: self.psku,
        name: self.pname,
        category: self.pcategory,
        brand: self.pbrand,
        model: self.pmodel,
        serialNumber: self.pserial,
        imeI1: self.pIMEI1,
        imeI2: self.pIMEI2,
        barCode: self.pbarcode,
        costPrice: self.pcost,
        unitPrice: self.punit,
        quantity: self.pquantity
    };

    self.Products = ko.observableArray([]);

    GetProducts();

    self.save = function () {
        return ajaxRequest("post", productUrl(), product)
            .done(function (result) {
                product.productId = result.productId;
                self.gtest(!self.gtest());
                self.ptest(!self.ptest());
                GetProducts();
                loadSectionList();
            })
            .fail(function () {
                alert("Error adding a new Product.");
            });
    };

    self.update = function () {
        return ajaxRequest("put", productUrl(self.pid()), product, "text")
            .done(function () {
                self.gtest(!self.gtest());
                self.ptest(!self.ptest());
                GetProducts();
                loadSectionList();
            })
          .fail(function () {
              alert("Error updating the Product.");
          });
    };


    self.deleterec = function (product) {
        return ajaxRequest("delete", productUrl(product.productId))
        .done(function () {
            GetProducts();
        })
         .fail(function () {
             alert("Error removing Product.");
         });
    };


    function GetProducts() {
        return ajaxRequest("get", productUrl())
            .done(getSucceeded)
            .fail(getFailed);

        function getSucceeded(data) {
            self.Products(data);
        }

        function getFailed() {
            alert("Error retrieving Product.");
        }
    }

    self.getselectedproduct = function (product) {

        //console.log(product);

        self.ptest(!self.ptest());
        self.gtest(!self.gtest());
        self.utest(true);
        self.stest(false);

        self.pid(product.productId),
        self.psku(product.sku),
        self.pname(product.name),
        self.pcategory(product.category),
        self.pbrand(product.brand),
        self.pmodel(product.model),
        self.pserial(product.serialNumber),
        self.pIMEI1(product.imeI1),
        self.pIMEI2(product.imeI2),
        self.pbarcode(product.barCode),
        self.pcost(product.costPrice),
        self.punit(product.unitPrice),
        self.pquantity(product.quantity)
        loadSectionForm();

    };


    self.viewtable = function () {
        self.gtest(!self.gtest());
        self.ptest(!self.ptest());
        GetProducts();
        loadSectionList();
    };

    self.viewform = function () {
        self.ptest(!self.ptest());
        self.gtest(!self.gtest());
        self.stest(true);
        self.utest(false);
        self.pid("0");
        self.psku("");
        self.pname("");
        self.pcategory("");
        self.pbrand(""),
        self.pmodel(""),
        self.pserial(""),
        self.pIMEI1(""),
        self.pIMEI2(""),
        self.pbarcode(""),
        self.pcost("");
        self.punit("");
        self.pquantity("");
        loadSectionForm();
    };

    function ajaxRequest(type, url, data, dataType) {
        var options = {
            dataType: dataType || "json",
            contentType: "application/json",
            cache: false,
            type: type,
            data: ko.toJSON(data)
        };
        return $.ajax(url, options);
    }
    function productUrl(id) { return "/api/ProductInfoAPI/" + (id || ""); }

};


$(document).ready(function () {

    ko.applyBindings(new ProductViewModel());

});