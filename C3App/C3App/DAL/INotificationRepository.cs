﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface INotificationRepository
    {
        long InsertNotification(Notification notification);
    }
}
