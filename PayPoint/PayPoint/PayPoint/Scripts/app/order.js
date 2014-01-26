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



var CartLine = function (prod) {

    var product = prod[0];
    var self = this;
    var total = "";
    var serial = 1;
    var stock = product.stock;
    var price = product.price;
    var psku = product.sku;
    self.serial = serial;
    self.name = product.name;
    self.stock = stock;
    self.price = price;
    self.sku = psku;
    self.productId = product.productId;
    self.category = product.category;
    self.brand = product.brand;
    self.model = product.model;
    self.sl = product.sl;
    self.im1 = product.im1;
    self.im2 = product.im2;
    self.barcode = product.barcode;
    self.cost = product.cost;
    self.quantity = ko.observable(1);
    self.productcode = product.productcode;
    self.producttype = product.producttype;
    self.stockupdate = product.stockupdate;
    self.status = product.status;
    
   
    self.item = product.brand + " " + product.model;

    self.subtotal = ko.computed(function () {
        return price * parseFloat("0" + self.quantity(), 10).toFixed(2);
    });

};


var OrderViewModel = function () {
    //Make the self as 'this' reference
    var self = this;
    self.query = ko.observable("");
    var productlist = [];
    self.ptest = ko.observable(false);
    self.gtest = ko.observable(true);
    self.stest = ko.observable(false);
    self.utest = ko.observable(false);
    self.rtest = ko.observable(false);
    self.odetails = ko.observable(false);

    self.Products = ko.observableArray([]);

    self.amount = ko.observable("0");
    self.paymentTypes = ko.observableArray(["Cash", "Card"]);
    self.selectedType = ko.observable("");

    var now = new Date();
    
    var then = (now.getMonth() + 1) + '-' + now.getDate() + '-' + now.getFullYear();
    then += ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();


    self.today = then;
   
    $.ajax({
        type: "GET",
        url: "/api/ProductInfoAPI",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
           // console.log(data);
            for (var i in data) {
                var item = data[i];
                productlist.push({
                    "productId": data[i].productId,
                    "name": data[i].name,
                    "sku": data[i].sku,
                    "category": data[i].category,
                    "brand": data[i].brand,
                    "model": data[i].model,
                    "sl": data[i].serialNumber,
                    "im1": data[i].imeI1,
                    "im2": data[i].imeI2,
                    "barcode": data[i].barCode,
                    "stock": data[i].quantity,
                    "cost": data[i].costPrice,
                    "price": data[i].unitPrice,
                    "productcode": data[i].productCode,
                    "producttype": data[i].productType,
                    "stockupdate": data[i].stockUpdate,
                    "status": data[i].status
                });
            }
           // console.log(productlist);

        },
        error: function (error) {
            alert(error.status + "<--and--> " + error.statusText);
        }
    });


    
    self.query.subscribe(function (newValue) {
       var searchproduct = [];
       for (i = 0; i < productlist.length; i++)
       {
           var str = productlist[i].barcode;
           var pstatus = productlist[i].status;
           if (newValue == str && pstatus!=1)
           {
               searchproduct.push({
                   "productId": productlist[i].productId,
                   "name": productlist[i].name,
                   "sku": productlist[i].sku,
                   "category": productlist[i].category,
                   "brand": productlist[i].brand,
                   "model": productlist[i].model,
                   "sl": productlist[i].sl,
                   "im1": productlist[i].im1,
                   "im2": productlist[i].im2,
                   "barcode": productlist[i].barcode,
                   "stock": productlist[i].stock,
                   "cost": productlist[i].cost,
                   "price": productlist[i].price,
                   "productcode": productlist[i].productcode,
                   "producttype": productlist[i].producttype,
                   "stockupdate": productlist[i].stockupdate,
                   "status": productlist[i].status
               });

               var model = searchproduct[0].model;
               var brand = searchproduct[0].brand;
               var category = searchproduct[0].category;

               var purl = "/api/productinfoapi?model=" + model + "&brand=" + brand + "&category=" + category;

               $.ajax({
                   type: "GET",
                   url: purl,
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (data) {
                       searchproduct[0].stock = data;
                   },
                   error: function (error) {
                       alert(error.status + "<--and--> " + error.statusText);
                   }
               });

           }
       }
       
       console.log(searchproduct);
       self.Products(searchproduct);

    });

    
    self.lines = ko.observableArray([]);

    self.addLine = function () {
        var product = self.Products();
        self.query("");
        self.lines.push(new CartLine(product));


    };

    self.removeLine = function (line) {
       
        self.lines.remove(line);
        
    };

    self.vat = ko.observable("0");
    self.dis = ko.observable("0");


    self.grandTotal = ko.computed(function () {
        var total = 0;
        $.each(self.lines(), function () { total += this.subtotal() })

        return total;
    });

    self.finalTotal = ko.computed(function () {
        var total = 0;

        var vat = parseFloat(self.grandTotal()) * (parseFloat(self.vat()) / 100);
        //var dis = parseFloat(self.grandTotal()) * (parseFloat(self.dis()) / 100);

        var dis = parseFloat(self.dis());
       // alert(dis);

        total = parseFloat(self.grandTotal() + vat - dis).toFixed(2);

        return total;
    });

    self.avat = ko.computed(function () {
        var total = 0;
        total = (parseFloat(self.grandTotal()) * (parseFloat(self.vat()) / 100)).toFixed(2);
        return total;
    });

    self.adis = ko.computed(function () {
        var total = 0;
        total = parseFloat(self.dis()); //(parseFloat(self.grandTotal()) * (parseFloat(self.dis()) / 100)).toFixed(2);
       // alert("total" + total);
        return total;
    });

    self.lamount = ko.computed(function () {
        var total = 0;
        total = parseFloat(self.amount() - self.finalTotal()).toFixed(2);
        return total;
    });



    self.save = function () {

        var orderNum = "O-" + new Date().getFullYear();

        $.ajax({
            type: "GET",
            url: "/api/OrderInfoAPI?ordernum",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
              
                var id = parseInt(data) + 1 ;              
                orderNum = orderNum + "-" + id;
                
                var OrderData = $.map(self.lines(), function (line) {
                    return line.item ? {
                        item: line.sku,
                        price: line.price,
                        name: line.name,
                        sku: line.sku,
                        left: line.stock,
                        productId: line.productId,
                        category: line.category,
                        brand: line.brand,
                        model: line.model,
                        sl: line.sl,
                        im1: line.im1,
                        im2: line.im2,
                        barcode: line.barcode,
                        cost: line.cost,
                        quantity: line.quantity(),
                        productcode: line.productcode,
                        producttype: line.producttype,
                        stockupdate: line.stockupdate,
                        status: line.status,
                        discount: 0
                    } : undefined
                });

                var paid = (parseFloat(self.amount()) - parseFloat(self.finalTotal())).toFixed(2);
                //paid = Math.round(paid);

                var inc = 0;
                var count = OrderData.length;

                for (var i in OrderData) {

                    var data = OrderData[i];
                    var upstock = (parseFloat(OrderData[i].left) - parseFloat(OrderData[i].quantity)).toFixed(2);

                    var name = OrderData[i].brand + " " + OrderData[i].model ;
                 

                    var order = {
                        orderNumber: orderNum,
                        item: name,
                        barCode: OrderData[i].barcode,
                        quantity: 1,
                        discount: self.dis(),
                        vat: self.vat(),
                        price: OrderData[i].price,
                        status: "paid",
                        amountReceived: self.amount(),
                        createdTime: self.today,
                        paymentType: self.selectedType()
                    };

                    
                   
                    //alert("product id is " + OrderData[i].proid + "sku is " + OrderData[i].item);

                    var upproduct = {
                        productId: data.productId,
                        sku: data.item,
                        name: data.name,
                        category: data.category,
                        brand: data.brand,
                        model: data.model,
                        serialNumber: data.sl,
                        imeI1: data.im1,
                        imeI2: data.im2,
                        barCode: data.barcode,
                        costPrice: data.cost,
                        unitPrice: data.price,
                        productCode: data.productcode,
                        productType: data.producttype,
                        stockUpdate: data.stockupdate,
                        status: 1,
                        stockSold: then,
                        quantity: 1
                    };

                   // console.log(upproduct);
                     //console.log(order);

                    var pupurl = "/api/ProductInfoAPI/" + data.productId;
                    //alert(pupurl);

                    $.ajax({
                        type: "PUT",
                        url: pupurl,
                        data: JSON.stringify(upproduct),
                        contentType: "application/json",
                        success: function (data) {
                            //alert("Record Updated Successfully ");

                        },
                        error: function (error) {
                            alert(error.status + "<!----!>" + error.statusText);
                        }
                    });
                    



                    $.ajax({
                        type: "POST",
                        url: "/api/OrderInfoAPI",
                        data: JSON.stringify(order),
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {

                            inc = parseInt(inc) + 1;

                            self.message = ko.observable(paid);

                            if (inc == parseInt(count))
                            {
                                //$(".wrapper").hide();
                                //$(".wrapper-print").show();

                                //alert("Return Amount is: " + paid);
                                window.open("/Orders/create?" + orderNum, "mywindow");
                                location.reload();
                            }
                        },
                        error: function () {
                            alert("Failed");
                        }
                    });



                }


            },
            error: function (error) {
                alert(error.status + "<--and--> " + error.statusText);
            }
        });

    };

    self.Orders = ko.observableArray([]);

    self.UnqOrders = ko.observableArray([]);

    var uniqueorder = [];

    function GetUnqOrders() {
        //Ajax Call Get All Employee Records
        var uniqueorder = [];
        $.ajax({
            type: "GET",
            url: "/api/OrderInfoAPI?distinct",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                for (var i in data) {
                    uniqueorder.push(data[i]);
                }

                var uniqueNames = [];
                $.each(uniqueorder, function (i, el) {
                    if ($.inArray(el, uniqueNames) === -1) uniqueNames.push(el);
                });


                var unique = [];

                for (var i in uniqueNames) {

                    unique.push({ "name": uniqueNames[i] });

                }


                self.UnqOrders(unique);

                console.log(unique);

            },
            error: function (error) {
                alert(error.status + "<--and--> " + error.statusText);
            }
        });
        //Ends Here
    }
  

    self.detailOrder = function (order) {

      //  alert("hi" + order.name);
        self.odetails(true);
        var name = order.name;
        var url = "/api/OrderInfoAPI?ordername=" + order.name;
      //  alert(url);
        $.ajax({
            type: "GET",
            url: url,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
               
                self.Orders(data);
            },
            error: function (error) {
                alert(error.status + "<--and--> " + error.statusText);
            }
        });

    };

   

  
    self.viewtable = function () {
        self.gtest(!self.gtest());
        self.ptest(!self.ptest());
        self.rtest(false);
        loadSectionList();
    };

    

    self.viewform = function () {
        self.ptest(!self.ptest());
        self.gtest(!self.gtest());
        self.stest(true);
        self.utest(false);
        GetUnqOrders();
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
    function orderUrl(id) { return "/api/OrderInfoAPI/" + (id || ""); }

};


$(document).ready(function () {

    ko.applyBindings(new OrderViewModel());

});