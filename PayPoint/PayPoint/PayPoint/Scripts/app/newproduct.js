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



var CartLine = function () {

    var self = this;
    self.serial = ko.observable("");
    self.im1 = ko.observable("");
    self.im2 = ko.observable("");
    self.barcode = ko.observable("");
   

};


var NewProductViewModel = function () {
    //Make the self as 'this' reference
    var self = this;
    self.ptest = ko.observable(false);
    self.gtest = ko.observable(true);
    self.stest = ko.observable(false);
    self.utest = ko.observable(false);
    self.rtest = ko.observable(false);
    self.qtest = ko.observable(false);
    self.ctest = ko.observable(false);
    self.mtest = ko.observable(false);
    self.btest = ko.observable(false);
    self.actest = ko.observable(false);
    self.amtest = ko.observable(false);
    self.abtest = ko.observable(false);

    self.Products = ko.observableArray([]);
    GetProducts();

    var productlist = [];
    self.lines = ko.observableArray([new CartLine()]);

  
    self.addLine = function () {
        self.lines.push(new CartLine());
    };
    self.lines.reverse();
    self.removeLine = function (line) {

        self.lines.remove(line);

    };

    var catagories = [];
    self.Categories = ko.observableArray([]);

    var models = [];
    self.Models = ko.observableArray([]);

    var brands = [];
    self.Brands = ko.observableArray([]);

    GetCategories();
    GetModels();
    GetBrands();


    function GetCategories() {

        $.ajax({
            type: "GET",
            url: "/api/CategoryInfoAPI",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //console.log(data);
                self.Categories(data);
            },
            error: function (error) {
                alert(error.status + "<--and--> " + error.statusText);
            }
        });
    }

    function GetModels() {

        $.ajax({
            type: "GET",
            url: "/api/ModelInfoAPI",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //console.log(data);
                self.Models(data);
            },
            error: function (error) {
                alert(error.status + "<--and--> " + error.statusText);
            }
        });
    }

    function GetBrands() {

        $.ajax({
            type: "GET",
            url: "/api/BrandInfoAPI",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                //console.log(data);
                self.Brands(data);
            },
            error: function (error) {
                alert(error.status + "<--and--> " + error.statusText);
            }
        });
    }

    self.cid = ko.observable("0");
    self.mid = ko.observable("0");
    self.bid = ko.observable("0");

    self.dcategory = ko.observable("");
    self.dmodel = ko.observable("");
    self.dbrand = ko.observable("");

    self.selectedCategoryValue = ko.observable("");
    self.selectedModelValue = ko.observable("");
    self.selectedBrandValue = ko.observable("");


    self.visiblecategory = function () {

        self.ctest(!self.ctest());
        self.actest(!self.actest());
        self.dcategory("");

    };

    self.visiblemodel = function () {

        self.mtest(!self.mtest());
        self.amtest(!self.amtest());
        self.dmodel("");

    };

    self.visiblebrand = function () {

        self.btest(!self.btest());
        self.abtest(!self.abtest());
        self.dbrand("");

    };

   

    self.addcategory = function () {
      
        var category = {
            contactId: self.cid,
            name: self.dcategory
        };

        $.ajax({
            type: "POST",
            url: "/api/CategoryInfoAPI",
            data: ko.toJSON(category),
            contentType: "application/json",
            success: function (data) {
               // alert("Record Added Successfully");
                self.ctest(false);
                self.actest(false);
                GetCategories();
               
            },
            error: function () {
                alert("Failed");
            }
        });


    };

    self.addmodel = function () {
       
        var model = {
            modelId: self.mid,
            name: self.dmodel
        };

        $.ajax({
            type: "POST",
            url: "/api/ModelInfoAPI",
            data: ko.toJSON(model),
            contentType: "application/json",
            success: function (data) {
                // alert("Record Added Successfully");
                self.mtest(false);
                self.amtest(false);
                GetModels();

            },
            error: function () {
                alert("Failed");
            }
        });



    };

    self.addbrand = function () {
     
        var brand = {
            brandId: self.bid,
            name: self.dbrand
        };

        $.ajax({
            type: "POST",
            url: "/api/BrandInfoAPI",
            data: ko.toJSON(brand),
            contentType: "application/json",
            success: function (data) {
                // alert("Record Added Successfully");
                self.btest(false);
                self.abtest(false);
                GetBrands();

            },
            error: function () {
                alert("Failed");
            }
        });



    };

    var now = new Date();
    var then = (now.getMonth() + 1) + '-' + now.getDate() + '-' + now.getFullYear();
    then += ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();

   // alert(then);
  
   
    self.pid = ko.observable("0");
    self.category = ko.observable("");
    self.model = ko.observable("");
    self.brand = ko.observable("");
    self.code = ko.observable("");
    self.type = ko.observable("");
    self.price = ko.observable("");
    self.cprice = ko.observable("");
    self.psku = ko.observable("");
    self.pname = ko.observable("");
    self.pserial = ko.observable("");
    self.pim1 = ko.observable("");
    self.pim2 = ko.observable("");
    self.pbarcode = ko.observable("");
    self.pstatus = ko.observable(0);
    self.stockupdate = then;

    self.getselectedproduct = function (product) {

        //console.log(product);

        self.ptest(!self.ptest());
        self.gtest(!self.gtest());
        self.utest(true);
        self.stest(false);
        self.pid(product.productId);
        self.psku(product.sku),
        self.pname(product.name),
        self.category(product.category),
        self.brand(product.brand),
        self.model(product.model),
        self.code(product.productCode),
        self.type(product.productType),
        self.pserial(product.serialNumber),
        self.pim1(product.imeI1),
        self.pim2(product.imeI2),
        self.pbarcode(product.barCode),
        self.price(product.unitPrice),
        self.cprice(product.costPrice),
        self.pstatus(product.status),
        //self.stockupdate(product.stockUpdate)

    
        loadSectionForm();

    };





    self.save = function () {

        //alert("category is " + self.selectedCategoryValue());

        var cat = self.selectedCategoryValue();
        var md = self.selectedModelValue();
        var bd = self.selectedBrandValue();

        var ProductData = $.map(self.lines(), function (line) {
            return line.barcode ? {
                    serial: line.serial(),
                    im1: line.im1(),
                    im2: line.im2(),
                    barcode: line.barcode()
                } : undefined
            });

        var inc = 0;
        var count = ProductData.length;

        for (var i in ProductData) {

            var data = ProductData[i];

            var product = {
                name: "",
                sku: "",
                category: cat,
                model: md,
                brand: bd,
                productCode: self.code(),
                productType: self.type(),
                unitPrice: self.price(),
                costPrice: self.cprice(),
                serialNumber: data.serial,
                imeI1: data.im1,
                imeI2: data.im2,
                status: 0,
                stockUpdate: then,
                barCode: data.barcode
            };

            //console.log(product);

            $.ajax({
                type: "POST",
                url: "/api/ProductInfoAPI",
                data: JSON.stringify(product),
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    inc = parseInt(inc) + 1;
                    if (inc == parseInt(count)) {
                        alert("Product Added Successfully");
                        location.reload();
                    }
                },
                error: function () {
                    alert("Failed");
                }
            });

        }//for


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

    self.update = function () {

        var product = {
            productId: self.pid(),
            name: self.pname(),
            sku: self.psku(),
            category: self.category(),
            model: self.model(),
            brand: self.brand(),
            productCode: self.code(),
            productType: self.type(),
            unitPrice: self.price(),
            costPrice: self.cprice(),
            serialNumber: self.pserial(),
            imeI1: self.pim1(),
            imeI2: self.pim2(),
            status: 0,
            stockUpdate: then,
            barCode: self.pbarcode()
        };

       // console.log(product);

        return ajaxRequest("put", productUrl(self.pid()), product, "text")
            .done(function () {
                self.gtest(!self.gtest());
                self.ptest(!self.ptest());
                GetProducts();
                loadSectionList();
            })
          .fail(function () {
              alert("Error updating the product.");
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

        self.category("");
        self.model("");
        self.brand("");
        self.code("");
        self.type("");
        self.price("");
        self.cprice("");
        self.psku("");
        self.pname("");
        self.pserial("");
        self.pim1("");
        self.pim2("");
        self.pbarcode("");
        self.selectedCategoryValue(null);
        self.selectedBrandValue(null);
        self.selectedModelValue(null);
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
    ko.applyBindings(new NewProductViewModel());
});