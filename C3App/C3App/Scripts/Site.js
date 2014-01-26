var PageLoadCount = 0;
; (function ($, window, undefined) {
    'use strict';

    var $doc = $(document),
        Modernizr = window.Modernizr;
    
    $(document).ready(function () {
        // Open first slide on page load for public pages
        //$('.details-tab .tab-content').mCustomScrollbar({
        //    advanced: {
        //        updateOnContentResize: true
        //    }
        //});
        GoToSlide(0);

        function showLoading(val) {
            if (!val) {
                val = '.container-wrapper';
            }
            $(val).append('<div class="loading-back"></div>');
            $(val + " .loading-back").show();
        }
        function hideLoading(val) {
            $(val + " .loading-back").fadeOut('fast');
        }
        
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);

        $(window).bind("resize", function () {
            $(".login-form-line").css("height", ($(window).innerHeight() - 220) + "px");
        }).resize();

        $.fn.foundationAlerts ? $doc.foundationAlerts() : null;
        $.fn.foundationButtons ? $doc.foundationButtons() : null;
        $.fn.foundationAccordion ? $doc.foundationAccordion() : null;
        $.fn.foundationNavigation ? $doc.foundationNavigation() : null;
        $.fn.foundationTopBar ? $doc.foundationTopBar() : null;
        $.fn.foundationCustomForms ? $doc.foundationCustomForms() : null;
        $.fn.foundationMediaQueryViewer ? $doc.foundationMediaQueryViewer() : null;
        $.fn.foundationTabs ? $doc.foundationTabs({ callback: $.foundation.customForms.appendCustomMarkup }) : null;
        $.fn.foundationTooltips ? $doc.foundationTooltips() : null;
        $.fn.foundationMagellan ? $doc.foundationMagellan() : null;
        $.fn.foundationClearing ? $doc.foundationClearing() : null
        $.fn.placeholder ? $('input, textarea').placeholder() : null;

        // Panel Making
        $(window).bind("resize", makePanelNoTransition).resize();

        


        function NavSubDropdown() {
            $(".main-nav li").children("a").click(function (event) {
                $(this).parent().siblings().removeClass("open");
                $(this).parent().toggleClass("open");
                $(this).parent().siblings().children("ul").children(".submenu").removeClass("open");
                if ($(this).parent().hasClass("open")) {
                }
            })
        }
        NavSubDropdown();

        function NavClose() {
            $(".main-nav").animate({
                left: '-1000px'
            }, function () {
                $(".main-nav").removeClass("open");
                $(".main-control").removeClass("active");
            })
        }

        function NavOpen() {
            $(".main-nav").animate({
                left: 0
            }, function () {
                $(".main-nav").addClass("open");
                $(".main-control").addClass("active");
            })
        }

        function NavControl() {
            $(".main-control").click(function (event) {
                event.stopPropagation();
                $(".dropdown").removeClass("open");
                if ($(".main-nav").hasClass("open")) {
                    NavClose();
                } else {
                    NavOpen();
                }
            })
            $(".main-nav").click(function (event) {
                event.stopPropagation();
            })
        }
        NavControl();

        $('.ui-datepicker > *').live('click', function (event) {
            event.stopPropagation();
        });
        
        $('.ui-datepicker-next').live('click', function (event) {
            event.stopPropagation();
        });
        $('.ui-datepicker-prev').live('click', function (event) {
            event.stopPropagation();
        });

        $(".search-label").live("click", function () {
            $(this).siblings().removeClass("active");
            $(this).addClass("active");
        })

        //$(".list-form td").live("click", function (e) {
        //    $(".list-form td.active").removeClass("active");
        //    $(this).addClass("active");
        //})

        $(".modal-close-btn").click(function () {
            var selector = $(this).parents('.modal-pop').attr('id');
            CloseModal(selector);
            var subSelector = $(this).parents('.modal-pop').attr('Child-Modal');
            CloseCreateModal(subSelector);
        })

        $(".create-modal-close-btn").click(function () {
            var selector = $(this).parents('.modal-create-panel').attr('id');
            CloseCreateModal(selector);
        })

        $(".modal-pop").click(function (event) {
            event.stopPropagation();
        })

        $(".modal-create-panel").click(function (event) {
            event.stopPropagation();
        })        

        $(".control-btn.has-confirm").live('click', function (e) {
            e.preventDefault();
            if ($(this).is('.open')) {
                return false;
            } else {
                $(this).parents('li').siblings().children('.slide-confirm').animate({
                    left: '0px'
                }, function () {
                   $('.control-btn.has-confirm').removeClass('open');
                });
                $(this).parents('.slide-confirm').animate({
                    left: '-140px',
                });
                $(this).addClass('open');
            }
        })
        $(".slide-cancel").live('click', function (e) {
            e.preventDefault();
            $(this).parents('.slide-confirm').animate({
                left: '0px'
            });
            $(this).siblings('.has-confirm').removeClass('open');
        })

        $('.reveal-modal-bg').click(function () {
            var link = $('.reveal-modal a.close-reveal-modal').attr('href');
            if (link) {
                window.location.href = link;
            }
        })

        // Copy some navigation links into marketing (Incomplete)
        function copyNavElements(value) {
            $.each(value, function (index, value) {
                var selector = $('a:contains:(value)');
                selector.css('background-color', '#000000');
            })
        }
        copyNavElements(['Accounts']);

        // Masked input value creater
        function makeMaskVal(value, length) {
            var tempMask = value.toString();
            for (var i = 1 ; i < length ; i++) {
                tempMask += value;
            }
            return tempMask.toString();
        }

        //Masked Input Validation
        //$.mask.definitions['n'] = "[a-zA-Z''-' ]";
        //$.mask.definitions['p'] = "[0-9+]";
        //$.mask.definitions['e'] = "[a-zA-Z0-9._-@]";
        //$.mask.definitions['u'] = "[a-zA-Z0-9:\&_]";
        //$.mask.definitions['z'] = "[0-9]";
        //$.mask.definitions['s'] = "[a-zA-Z0-9\s()/,:;.-]";
        //$.mask.definitions['c'] = "[0-9.]";
        //$(".maskedname").mask(makeMaskVal("n", 30), { placeholder: " " });
        //$(".maskedphone").mask(makeMaskVal("p", 30), { placeholder: " " });
        //$(".maskedemail").mask(makeMaskVal("e", 30), { placeholder: " " });
        //$(".maskedurl").mask(makeMaskVal("u", 50), { placeholder: " " });
        //$(".maskedzip").mask(makeMaskVal("u", 50), { placeholder: " " });
        //$(".maskedstreet").mask(makeMaskVal("u", 50), { placeholder: " " });
        //$(".maskedcurrency").mask(makeMaskVal("c", 20), { placeholder: " " });

        // Account Details Page
        $("input[id*='AccountDetailsView___Name']").addClass("required-field").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___Website']").keyfilter(/[a-zA-Z0-9:\-.?+@#$&%;]/);
        $("input[id*='AccountDetailsView___Employees']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___Ownership']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___OfficePhone']").keyfilter(/[\d+]/);
        $("input[id*='AccountDetailsView___Fax']").keyfilter(/[\d+]/);
        $("input[id*='AccountDetailsView___AlternatePhone']").keyfilter(/[\d+]/);
        $("input[id*='AccountDetailsView___PrimaryEmail']").keyfilter(/[a-z0-9_\.\-@]/i);
        $("input[id*='AccountDetailsView___AlternateEmail']").keyfilter(/[a-z0-9_\.\-@]/i);
        $("input[id*='AccountDetailsView___Rating']").keyfilter(/[\d\.\s,]/);
        $("input[id*='AccountDetailsView___AnnualRevenue']").keyfilter(/[\d\.\s,]/);
        $("input[id*='AccountDetailsView___BillingStreet']").keyfilter(/[a-zA-Z0-9\s()\/,:;.-]/);
        $("input[id*='AccountDetailsView___BillingCity']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___BillingState']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___BillingPost']").keyfilter(/[\d+]/);
        $("input[id*='AccountDetailsView___ShippingStreet']").keyfilter(/[a-zA-Z0-9\s()\/,:;.-]/);
        $("input[id*='AccountDetailsView___ShippingCity']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___ShippingState']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='AccountDetailsView___ShippingPost']").keyfilter(/[\d+]/);
        $("input[id*='AccountDetailsView___Description']").keyfilter(/[a-zA-Z\-\'. ]/);

        // Leads Details Page
        $("input[id*='LeadsDetailsView___ReferredBy']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___Title']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___Department']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___Website']").keyfilter(/[a-zA-Z0-9:\-.?+@#$&%;]/);
        $("input[id*='LeadsDetailsView___PhoneWork']").keyfilter(/[\d+]/);
        $("input[id*='LeadsDetailsView___PhoneMobile']").keyfilter(/[\d+]/);
        $("input[id*='LeadsDetailsView___PhoneHome']").keyfilter(/[\d+]/);
        $("input[id*='LeadsDetailsView___PhoneOther']").keyfilter(/[\d+]/);
        $("input[id*='LeadsDetailsView___Fax']").keyfilter(/[\d+]/);
        $("input[id*='LeadsDetailsView___PrimaryEmail']").keyfilter(/[a-z0-9_\.\-@]/i);
        $("input[id*='LeadsDetailsView___AlternateEmail']").keyfilter(/[a-z0-9_\.\-@]/i);
        $("input[id*='LeadsDetailsView___PrimaryStreet']").keyfilter(/[a-zA-Z0-9\s()\/,:;.-]/);
        $("input[id*='LeadsDetailsView___PrimaryCity']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___PrimaryState']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___PrimaryPostalCode']").keyfilter(/[\d+]/);
        $("input[id*='LeadsDetailsView___AlternateStreet']").keyfilter(/[a-zA-Z0-9\s()\/,:;.-]/);
        $("input[id*='LeadsDetailsView___AlternateCity']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___AlternateState']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='LeadsDetailsView___AlternatePostalCode']").keyfilter(/[\d+]/);

        // Opportunity Details Page
        $("input[id*='OpportunityDetailsView___Name']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='OpportunityDetailsView___Amount']").keyfilter(/[\d\.\s,]/);
        $("input[id*='OpportunityDetailsView___NextStep']").keyfilter(/[a-zA-Z0-9\s()\/,:;.-]/);
        $("input[id*='OpportunityDetailsView___Probability']").keyfilter(/[\d\.\s,]/);

        // Order Detail Page
        $("input[id*='OrdersDetailsView___Name']").addClass("required-field").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='OrdersDetailsView___BillingCity']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='OrdersDetailsView___BillingState']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='OrdersDetailsView___BillingZip']").keyfilter(/[\d+]/);
        $("input[id*='OrdersDetailsView___ShippingCity']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='OrdersDetailsView___ShippingState']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='OrdersDetailsView___ShippingZip']").keyfilter(/[\d+]/);
        $("input[id*='OrdersDetailsView___ConversionRate']").keyfilter(/[\d\.\s,]/);
        $("input[id*='OrdersDetailsView___TaxRate']").keyfilter(/[\d\.\s,]/);
        $("input[id*='OrdersDetailsView___Shipper']").keyfilter(/[a-zA-Z\-\'. ]/);

        // Product Details Page
        $("input[id*='ProductDetailsView___Name']").addClass("required-field").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='ProductDetailsView___SKU']").addClass("required-field");
        $("input[id*='ProductDetailsView___Color']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='ProductDetailsView___Weight']").keyfilter(/[a-z0-9_ ]/i);
        $("input[id*='ProductDetailsView___Quantity']").addClass("required-field").keyfilter(/[a-z0-9_ ]/i);
        $("input[id*='ProductDetailsView___Location']").keyfilter(/[a-z0-9_ ]/i);
        $("input[id*='ProductDetailsView___Website']").keyfilter(/[a-zA-Z0-9:\-.?+@#$&%;]/);
        $("input[id*='ProductDetailsView___Cost']").addClass("required-field").keyfilter(/[\d\.\s,]/);
        $("input[id*='ProductDetailsView___ListPrice']").keyfilter(/[\d\.\s,]/);
        $("input[id*='ProductDetailsView___DiscountPrice']").keyfilter(/[\d\.\s,]/);
        $("input[id*='ProductDetailsView___SupportName']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='ProductDetailsView___SupportContact']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='ProductDetailsView___SupportDescription']").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='ProductDetailsView___Description']").keyfilter(/[a-zA-Z\-\'. ]/);

        // Invoice
        $("input[id*='InvoiceDetailsView___Name']").addClass("required-field").keyfilter(/[a-zA-Z\-\'. ]/);
        $("input[id*='InvoiceDetailsView___AmountDue']").keyfilter(/[\d\.\s,]/);


    });

    if (Modernizr.touch && !window.location.hash) {
        $(window).load(function () {
            setTimeout(function () {
                window.scrollTo(0, 1);
            }, 0);
        });
    }

    function verticalCenter(element, parent, param, Offset) {
        if (parent == 'this') {
            parent = $(element).parent();
        } else {
            parent = $(parent);
        }
        $(element).css(
            param,
            ((parent.innerHeight() - $(element).outerHeight()) / 2 + parseInt(Offset)) + 'px'
            );
    }

    $(window).resize(function () {
        verticalCenter('.module-select', 'this', 'margin-top', '-100');
        verticalCenter('.module-select-content .vertical-center', '.module-select', 'margin-top', '-50');
    }).resize();

    function subTotal() {
        var sub_total = 0;

        function setDefault(variable) {
            if (variable == '') {
                variable = 0;
            } else {
                variable = parseFloat(variable);
            }
        }

        $.each($("input[id*='BodyContent_OrderDetailsGridView_ListPriceTextBox']"), function () {
            var listPrice = $(this).val();
            var quantity = $(this).parents('tr').find(("input[id*='BodyContent_OrderDetailsGridView_QuantityTextBox']")).val();
            var discount = $(this).parents('tr').find(("input[id*='BodyContent_OrderDetailsGridView_DiscountTextBox']")).val();

            setDefault(listPrice);
            setDefault(quantity);
            setDefault(discount);

            sub_total = sub_total + (listPrice * quantity); // without discount
            sub_total = parseInt(sub_total - (sub_total * (discount / 100))); // with discount

        })
        $("input[title='Subtotal']").attr('value', sub_total);
        var bigDiscount = $("input[title='Discount']").val();
        var shipping = $("input[title='Shipping']").val();
        var tax = $("input[title='Tax']").attr('value');

        setDefault(bigDiscount);
        setDefault(shipping);
        setDefault(tax);

        var total = sub_total - (sub_total * (bigDiscount / 100)); // with discount        
        total = parseInt(total + (total * (tax / 100))); // with tax
        total = total + shipping; // with shipping
        $("input[title='Total']").attr('value', total);
    }

    function observeKeyup(element) {
        $.each(element, function (index, value) {
            $(value).live('keyup', function () {
                subTotal();
            });
        });
    }

    observeKeyup([
        "input[id*='BodyContent_OrderDetailsGridView_ListPriceTextBox']",
        "input[id*='BodyContent_OrderDetailsGridView_DiscountTextBox']",
        "input[id*='BodyContent_OrderDetailsGridView_QuantityTextBox']",
        "input[title='Discount']",
        "input[title='Shipping']",
        "input[title='Tax']"
    ]);

})(jQuery, this);

// Panel Posizion Size Script
function makePanelNoTransition() {
    // var documentHeight = jQuery(window).innerHeight();
    var documentHeight = jQuery('body').height();
    var titleHeight = jQuery(".tab.active .tab-title").outerHeight();
    var ListHeight = jQuery(".tab.active .list-panel").outerHeight();
    var searchHeight = jQuery(".tab.active .search-panel").outerHeight();
    var miniDetailHeight = jQuery(".tab.active .mini-detail-panel").outerHeight();
    var miniDetailMoreHeight = jQuery(".tab.active .mini-detail-more-panel").outerHeight();
    var listReportHeight = jQuery('.tab.active .list-report').outerHeight();

    jQuery(".tab.active .list-panel").css("height", documentHeight - titleHeight - searchHeight + "px");
    jQuery(".tab.active .mini-detail-more-panel").css("height", documentHeight - titleHeight - searchHeight - miniDetailHeight + "px");
    jQuery(".meeting-big").css("height", jQuery(".mini-detail-more-panel").css("height"));
    jQuery('.tab.active .details-report').css('height', documentHeight - titleHeight - searchHeight - listReportHeight + 'px');
}

function replaceElement() {
    jQuery.each(jQuery('#BodyContent_OrdersDetailsView .replaced'), function () {
        var tempField = jQuery(this).parent('tr');
        var tempClone = tempField.clone();
        tempField.remove();
        tempClone.appendTo('#tableTotalDemo tbody');
    })

    jQuery.each(jQuery('#BodyContent_orderDetailsview .replaced'), function () {
        var tempField = jQuery(this).parent('tr');
        var tempClone = tempField.clone();
        tempField.remove();
        tempClone.appendTo('#tableInvoiceDemo tbody');
    })

    var buttonDemo1 = jQuery('#BodyContent_OrdersDetailsView #BodyContent_OrdersDetailsView_InsertLinkButton3').parent('td').parent('tr').clone();
    jQuery('#BodyContent_OrdersDetailsView #BodyContent_OrdersDetailsView_InsertLinkButton3').parent('td').parent('tr').remove();

    var buttonDemo2 = jQuery('#BodyContent_OrdersDetailsView #BodyContent_OrdersDetailsView_UpdateLinkButton').parent('td').parent('tr').clone();
    jQuery('#BodyContent_OrdersDetailsView #BodyContent_OrdersDetailsView_UpdateLinkButton').parent('td').parent('tr').remove();

    var buttonDemo3 = jQuery('#BodyContent_InvoiceDetailsView_InsertLinkButton').parent('td').parent('tr').clone();
    jQuery('#BodyContent_InvoiceDetailsView_InsertLinkButton').parent('td').parent('tr').remove();

    var buttonDemo4 = jQuery('#BodyContent_InvoiceDetailsView_UpdateLinkButton').parent('td').parent('tr').clone();
    jQuery('#BodyContent_InvoiceDetailsView_UpdateLinkButton').parent('td').parent('tr').remove();

    buttonDemo1.appendTo('#tableTotalDemo tbody');
    buttonDemo2.appendTo('#tableTotalDemo tbody');
    buttonDemo3.appendTo('#tableInvoiceDemo tbody');
    buttonDemo4.appendTo('#tableInvoiceDemo tbody');
}

function pageLoad(sender, args) {
    jQuery(".datepicker").datepicker();
    makePanelNoTransition();
    replaceElement();
    jQuery('.calendar-datepicker').datepicker();
    if (args.get_isPartialLoad()) {
        $.getScript('/Scripts/jquery.keyfilter.js');
    }
}
