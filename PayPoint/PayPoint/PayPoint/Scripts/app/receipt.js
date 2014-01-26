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


var ordernum = window.location.search.substring(1);


var ReceiptViewModel = function () {


    var now = new Date();
    var then = now.getDay() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();
    then += ' ' + now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();

    self.today = then;

    self.lines = ko.observableArray([]);
    self.vat = ko.observable("0");
    self.dis = ko.observable("0");
    self.amount = ko.observable("0");
    self.subtotal = ko.observable("0");
    self.paid = ko.observable("0");

    var str = ordernum;
    var rid = str.replace("O", "P");

    self.receipt = rid;

    $.ajax({
        type: "GET",
        url: "/api/OrderInfoAPI?ordername="+ordernum,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {
            console.log(data);
            self.lines(data);
            self.vat(data[0].vat);
            self.dis(data[0].discount);
            self.amount(data[0].amountReceived);
            self.paid(data[0].paymentType);
        },
        error: function () {
            alert("Failed");
        }
    });

    
    


    self.grandTotal = ko.computed(function () {
        var total = 0;
        $.each(self.lines(), function () { total += this.price })
        return total;
    });

    self.finalTotal = ko.computed(function () {
        var total = 0;

        var vat = parseFloat(self.grandTotal()) * (parseFloat(self.vat()) / 100);
        var dis = parseFloat(self.dis()); //parseFloat(self.grandTotal()) * (parseFloat(self.dis()) / 100);

        //alert(dis);

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
        //alert(total);
        return total;
    });

    self.lamount = ko.computed(function () {
        var total = 0;
        total = parseFloat(self.amount() - self.finalTotal()).toFixed(2);
        return total;
    });




}


$(document).ready(function(){

    ko.applyBindings(new ReceiptViewModel());

});