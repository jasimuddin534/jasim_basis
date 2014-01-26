// Hook up Application event handlers
var app = Sys.Application;
//app.add_load(ApplicationLoad);
app.add_init(ApplicationInit);
//app.add_disposing(ApplicationDisposing);
//app.add_unload(ApplicationUnload);

// Application event handlers
function ApplicationInit(sender) {
    var prm = Sys.WebForms.PageRequestManager.getInstance();
    if (!prm.get_isInAsyncPostBack()) {
        prm.add_pageLoaded(PageLoaded);
    }
}

$(document).ready(function () {
    
})

function PageLoaded(sender, args) {
   
}

function EndRequest(sender, args) {
    // End Requests
}

function ShowAlertModal() {
    $("#myModal").reveal({
        animation: 'fade',
    });
};

function ShowTextModal(heading, text) {
    $("#myModal").find('h4').html(heading);
    $("#myModal").find('span').html('<span style="color: red; font-weight: 400;">'+text+'</span>');
    $("#myModal").reveal({
        animation: 'fade',
    });
};

var slideLeft = '';
var activeSlide = '-1';
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-37375116-1']);
_gaq.push(['_trackPageview']);


function validatenumeric(key) {
    //getting key code of pressed key

    var keycode = (key.which) ? key.which : key.keyCode;
    //comparing pressed keycodes
    if (!(keycode == 8 || keycode == 46 || keycode == 9 || keycode == 11) && (keycode < 48 || keycode > 57)) {

        ShowTextModal('Validation Error', 'Only numbers are allowed');
        
        return false;
    }
    else {

        return true;
    }
}

function validatename(key,id) {

    var text = id.value;
    var patt = /^[A-z\s.-]{1,40}$/;
    var result=patt.test(text);
    if (result)
    {
        return true;
    }
    else
    {
        var keycode = (key.which) ? key.which : key.keyCode;
        if (!(keycode == 9 || keycode == 11) ) 
        ShowTextModal('Validation Error', 'Only Letters, Fullstop and Hyphen are allowed.');
        return false;
    }
}

function validatealphanumeric(key,id) {

    var text = id.value;
    var patt = /^[\w\s.-]{1,200}$/;
    var result = patt.test(text);
    if (result) {
        return true;
    }
    else {
        ShowTextModal('Validation Error', 'Only Letters, Fullstop and Hyphen are allowed.');
        return false;
    }
}


function validatetext(key,id) {

    var text = id.value;
    var patt = /^[\w\s\+?,'.-@#&{}\:;()]{1,200}$/;
    var result = patt.test(text);
    if (result) {
        return true;
    }
    else {
        ShowTextModal('Validation Error', 'Some Special Characters are not supported');
        return false;
    }
}



function GoToSlide(value) {

    if (value == 0) { slideLeft = '17%' }
    else if (value == 1) { slideLeft = '50%' }
    else if (value == 2) { slideLeft = '83.5%' }

    if (value == activeSlide) {
        return false;
    } else {
        $(".form-tab.active").removeClass("active");
        $(".reg-form-back").animate({
            left: slideLeft
        }, function () {
            activeSlide = value;
            $(".form-tab:eq(" + value + ")").addClass("active");
        });
    }
}

function GoToTab(value, selfText) {
    selectedTab = $(".tab[tab-id=" + value + "]");
    siblingTabs = selectedTab.siblings(".tab");
    tabCount = $(".tab").length;
    activeTabWidth = 100 - (12.5 * (tabCount - 1))
    if (selectedTab.hasClass("active")) {
        return false;
    } else {
        if (selfText != undefined) {
            if (value == 1) {
                selectedTab.find('.tab-title').text(selfText);
            } else if (value == 2) {
                siblingTabs.find('.tab-title').text(selfText);
            }           
        }
        selectedTab.children(".tab-title").animate({
            paddingLeft: "3%",
            color: "#D71E2F"
        });
        selectedTab.animate({
            width: activeTabWidth + '%',
            backgroundColor: '#C4C5C6'
        }, function () {
            selectedTab.children(".tab-content").fadeIn("slow", function () {
            });
            selectedTab
                .addClass("active")
        });
        siblingTabs.children(".tab-title").animate({
            paddingLeft: "6%",
            color: "#FFFFFF"
        });
        siblingTabs.children(".tab-content").fadeOut(100);
        siblingTabs.animate({
            width: '12.5%'
        }).animate({
            backgroundColor: '#D71E2F'
        }, function () {
            siblingTabs
                .removeClass("active")
        });
    }
}

function NavClose() {
    $(".main-nav").animate({
        left: '-1000px'
    }, function () {
        $(".main-nav").removeClass("open");
    })
}

function OpenModal(modalID) {
    var selector = $("#" + modalID)
    if (!selector.hasClass("open")) {
        selector.show();
        if (selector.hasClass('left')) {
            selector.animate({
                left: '0px'
            }, 400, function () {
                $(this).addClass("open");
            })
        } else if (selector.hasClass('right')) {
            selector.animate({
                right: '0px'
            }, 400, function () {
                $(this).addClass("open");
            })
        }
    }
}

function CloseModal(modalID) {
    var selector = $("#" + modalID);
    if (selector.hasClass("open")) {
        if (selector.hasClass('left')) {
            selector.animate({
                left: '-100%'
            }, 300, function () {
                $(this).removeClass("open");
                selector.hide();
            })
        } else if (selector.hasClass('right')) {
            selector.animate({
                right: '-100%'
            }, 300, function () {
                $(this).removeClass("open");
                selector.hide();
            })
        }
    }
}

function OpenCreateModal(modalID) {
    var selector = $("#" + modalID);
    if (!selector.hasClass("open")) {
        selector.show();
        if (selector.hasClass('left')) {
            selector.animate({
                left: '48%'
            }, 400, function () {
                $(this).addClass("open");
            })
        } else if (selector.hasClass('right')) {
            selector.animate({
                right: '48%'
            }, 400, function () {
                $(this).addClass("open");
            })
        }
    }
}

function CloseCreateModal(modalID) {
    var selector = $("#" + modalID);
    if (selector.hasClass("open")) {
        if (selector.hasClass('left')) {
            selector.animate({
                left: '-450px'
            }, 300, function () {
                $(this).removeClass("open");
                selector.hide();
            })
        } else if (selector.hasClass('right')) {
            selector.animate({
                right: '-450px'
            }, 300, function () {
                $(this).removeClass("open");
                selector.hide();
            })
        }
    }
}

function CloseModals(value) {
    $.each(value, function (index, value) {
        CloseModal(value);
        CloseCreateModal(value);
    })
}


$(".modal-pop").live('click', function (e) {
    e.stopPropagation();
})

function slideConfirm(value) {
    if (value == 'open') {
        $('.slide-confirm').animate({
            right: '0'
        });
    } else if (value == 'close') {
        $('.slide-confirm').animate({
            right: '-250px'
        }, function () {
            $(this).siblings('.has-confimr').removeClass('open');
        });
    }
}

$('.has-confirm').live('click', function (e) {
    e.stopPropagation();
})

$('.slide-confirm').live('click', function (e) {
    e.stopPropagation();
})

$('.modal-create-panel').live('click', function (e) {
    e.stopPropagation();
})

$(document).click(function (e) {
    if (e.which == 1) {
        NavClose();
        $('[id*="ModalPanel"]').each(function () {
            CloseModal($(this).attr('id'));
        })
        $('[class*="modal-create-panel"]').each(function () {
            CloseCreateModal($(this).attr('id'));
        })
        slideConfirm('close');
        $('.slide-confirm').animate({
            left: '0px'
        }, function () {
            $('.has-confirm').removeClass('open');
        });
    }
});