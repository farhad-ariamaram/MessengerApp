using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MessengerApp.DTO
{
    public class DTO
    {
        public class _Tbl_Messenger_Message
        {

            public long _Fld_Message_ID;

            public long _Fld_Communication_ID;

            public System.Nullable<long> _Fld_Attachment_ID;

            public System.Nullable<long> _Fld_Message_ReplayID;

            public long _Fld_Message_SenderID;

            public System.DateTime _Fld_Message_SendDateTime;

            public string _Fld_Message_Text;

            public bool _Fld_Message_Immediate;

            public System.Nullable<int> _Fld_Messenger_Joined_ID;

            public string _Fld_Messenger_Joined_Value;

            public long receiverId;

        }

        public class _Tbl_Messenger_User
        {
            public long _Fld_User_ID;

            public string _Fld_User_Name;
        }
    }
}