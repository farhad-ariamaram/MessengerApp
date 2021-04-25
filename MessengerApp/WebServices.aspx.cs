using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using static MessengerApp.DTO.DTO;

namespace MessengerApp
{
    public partial class WebServices : System.Web.UI.Page
    {

        //تابع پیدا کردن آی دی چت بین دو نفر یا CommunicationId
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static long? GetCommunicationId(string currentUserId, string SelectedUserId)
        {
            DCDataContext db = new DCDataContext();

            var q = db.SelectCommunicationId(Convert.ToInt64(currentUserId), Convert.ToInt64(SelectedUserId)).SingleOrDefault();

            if (q != null)
            {
                return q.Fld_Communication_ID;
            }

            //اگر بین دو کاربر تا حالا چتی ایجاد نشده بود یکی بساز
            Tbl_Messenger_Communication newCommunicationChat = new Tbl_Messenger_Communication()
            {
                Fld_Communication_ID = getLastCommunicationId() + 1,
                Fld_CommunicationType_ID = 1,
                Fld_Communication_Name = currentUserId + "To" + SelectedUserId,
            };

            db.Tbl_Messenger_Communications.InsertOnSubmit(newCommunicationChat);
            db.SubmitChanges();

            Tbl_Messenger_CommunicationUser newCommunicationUserCurrentUser = new Tbl_Messenger_CommunicationUser()
            {
                Fld_CommunicationUser_ID = getLastCommunicationUserId() + 1,
                Fld_User_ID = Convert.ToInt64(currentUserId),
                Fld_LastSeenID = 0,
                Fld_LastSeenDateTime = DateTime.Now,
                Fld_IsTop = false,
                Fld_Communication_ID = newCommunicationChat.Fld_Communication_ID
            };

            db.Tbl_Messenger_CommunicationUsers.InsertOnSubmit(newCommunicationUserCurrentUser);
            db.SubmitChanges();

            Tbl_Messenger_CommunicationUser newCommunicationUserCurrentSelectedUser = new Tbl_Messenger_CommunicationUser()
            {
                Fld_CommunicationUser_ID = getLastCommunicationUserId() + 1,
                Fld_User_ID = Convert.ToInt64(SelectedUserId),
                Fld_LastSeenID = 0,
                Fld_LastSeenDateTime = DateTime.Now,
                Fld_IsTop = false,
                Fld_Communication_ID = newCommunicationChat.Fld_Communication_ID
            };

            db.Tbl_Messenger_CommunicationUsers.InsertOnSubmit(newCommunicationUserCurrentSelectedUser);
            db.SubmitChanges();

            return newCommunicationChat.Fld_Communication_ID;
        }

        //تابع خواندن پیام ها
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<_Tbl_Messenger_Message> GetMessages(string communicationId)
        {
            DCDataContext db = new DCDataContext();
            var query = from a in db.Tbl_Messenger_Messages
                        where a.Fld_Communication_ID == Convert.ToInt64(communicationId)
                        select new _Tbl_Messenger_Message()
                        {
                            _Fld_Message_ID = a.Fld_Message_ID,
                            _Fld_Communication_ID = a.Fld_Communication_ID,
                            _Fld_Attachment_ID = a.Fld_Attachment_ID,
                            _Fld_Message_ReplayID = a.Fld_Message_ReplayID,
                            _Fld_Message_SenderID = a.Fld_Message_SenderID,
                            _Fld_Message_SendDateTime = a.Fld_Message_SendDateTime,
                            _Fld_Message_Text = a.Fld_Message_Text,
                            _Fld_Message_Immediate = a.Fld_Message_Immediate,
                            _Fld_Messenger_Joined_ID = a.Fld_Messenger_Joined_ID,
                            _Fld_Messenger_Joined_Value = a.Fld_Messenger_Joined_Value
                        };
            return query.ToList();
        }

        //تابع خواندن پاسخ پیام با آی دی
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static _Tbl_Messenger_Message GetReplyMessage(string replyMessageId)
        {
            DCDataContext db = new DCDataContext();
            var query = from a in db.Tbl_Messenger_Messages
                        where a.Fld_Message_ID == Convert.ToInt64(replyMessageId)
                        select new _Tbl_Messenger_Message()
                        {
                            _Fld_Message_ID = a.Fld_Message_ID,
                            _Fld_Communication_ID = a.Fld_Communication_ID,
                            _Fld_Attachment_ID = a.Fld_Attachment_ID,
                            _Fld_Message_ReplayID = a.Fld_Message_ReplayID,
                            _Fld_Message_SenderID = a.Fld_Message_SenderID,
                            _Fld_Message_SendDateTime = a.Fld_Message_SendDateTime,
                            _Fld_Message_Text = a.Fld_Message_Text,
                            _Fld_Message_Immediate = a.Fld_Message_Immediate,
                            _Fld_Messenger_Joined_ID = a.Fld_Messenger_Joined_ID,
                            _Fld_Messenger_Joined_Value = a.Fld_Messenger_Joined_Value
                        };
            return query.FirstOrDefault();
        }

        //ارسال پیام
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static _Tbl_Messenger_Message sendMessage(_Tbl_Messenger_Message obj)
        {
            DCDataContext db = new DCDataContext();

            Tbl_Messenger_Message t = new Tbl_Messenger_Message
            {
                Fld_Message_ID = obj._Fld_Message_ID,
                Fld_Communication_ID = obj._Fld_Communication_ID,
                Fld_Attachment_ID = obj._Fld_Attachment_ID,
                Fld_Message_ReplayID = obj._Fld_Message_ReplayID,
                Fld_Message_SenderID = obj._Fld_Message_SenderID,
                Fld_Message_SendDateTime = DateTime.Now,
                Fld_Message_Text = obj._Fld_Message_Text,
                Fld_Message_Immediate = obj._Fld_Message_Immediate,
                Fld_Messenger_Joined_ID = obj._Fld_Messenger_Joined_ID,
                Fld_Messenger_Joined_Value = obj._Fld_Messenger_Joined_Value
            };

            db.Tbl_Messenger_Messages.InsertOnSubmit(t);
            db.SubmitChanges();

            //در آخر پس از ثبت پیام در بانک همان را بازگشت میدهیم تا بتوانیم در صفحه نمایشش دهیم
            _Tbl_Messenger_Message t2 = new _Tbl_Messenger_Message()
            {
                _Fld_Message_ID = t.Fld_Message_ID,
                _Fld_Communication_ID = t.Fld_Communication_ID,
                _Fld_Attachment_ID = t.Fld_Attachment_ID,
                _Fld_Message_ReplayID = t.Fld_Message_ReplayID,
                _Fld_Message_SenderID = t.Fld_Message_SenderID,
                _Fld_Message_SendDateTime = t.Fld_Message_SendDateTime,
                _Fld_Message_Text = t.Fld_Message_Text,
                _Fld_Message_Immediate = t.Fld_Message_Immediate,
                _Fld_Messenger_Joined_ID = t.Fld_Messenger_Joined_ID,
                _Fld_Messenger_Joined_Value = t.Fld_Messenger_Joined_Value
            };

            return t2;
        }


        //گرفتن آخرین پیام دیده شده توسط کاربر دوم
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static long? GetLastSeenMessageId(string currentUserId, string communicationId)
        {
            DCDataContext db = new DCDataContext();
            var query = from a in db.Tbl_Messenger_CommunicationUsers
                        where a.Fld_Communication_ID == Convert.ToInt32(currentUserId) && a.Fld_User_ID == Convert.ToInt32(communicationId)
                        select a.Fld_LastSeenID;
            return query.SingleOrDefault();
        }

        //بروزرسانی آخرین پیام دیده شده کاربر به آی دی جدید
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static void UpdateLastseenId(string currentUserId, string communicationId, string newlastseenid)
        {
            DCDataContext db = new DCDataContext();

            var result = (from a in db.Tbl_Messenger_CommunicationUsers
                          where a.Fld_User_ID == Convert.ToInt64(currentUserId) && a.Fld_Communication_ID == Convert.ToInt64(communicationId)
                          select a).SingleOrDefault();
            result.Fld_LastSeenID = Convert.ToInt64(newlastseenid);

            db.SubmitChanges();
        }

        //گرفتن لیست کاربران
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static List<_Tbl_Messenger_User> GetUsersList(string currentUserId, string SelectedUserId)
        {
            DCDataContext db = new DCDataContext();

            var result = (from a in db.Tbl_Messenger_Users
                          where a.Fld_User_ID != Convert.ToInt64(currentUserId) && a.Fld_User_ID != Convert.ToInt64(SelectedUserId)
                          select new _Tbl_Messenger_User()
                          {
                              _Fld_User_ID = a.Fld_User_ID,
                              _Fld_User_Name = a.Fld_User_Name
                          });

            return result.ToList();
        }

        //تابع خواندن متن پیام با آی دی
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static _Tbl_Messenger_Message GetMessageBody(string messageId)
        {
            DCDataContext db = new DCDataContext();
            var query = from a in db.Tbl_Messenger_Messages
                        where a.Fld_Message_ID == Convert.ToInt64(messageId)
                        select new _Tbl_Messenger_Message()
                        {
                            _Fld_Message_ID = a.Fld_Message_ID,
                            _Fld_Communication_ID = a.Fld_Communication_ID,
                            _Fld_Attachment_ID = a.Fld_Attachment_ID,
                            _Fld_Message_ReplayID = a.Fld_Message_ReplayID,
                            _Fld_Message_SenderID = a.Fld_Message_SenderID,
                            _Fld_Message_SendDateTime = a.Fld_Message_SendDateTime,
                            _Fld_Message_Text = a.Fld_Message_Text,
                            _Fld_Message_Immediate = a.Fld_Message_Immediate,
                            _Fld_Messenger_Joined_ID = a.Fld_Messenger_Joined_ID,
                            _Fld_Messenger_Joined_Value = a.Fld_Messenger_Joined_Value
                        };
            return query.FirstOrDefault();
        }

        //تابعی برای بازگشت آخرین آی دی ثبت شده در جدول کامونیکیشن چون باید دستی افزوده شود
        public static long getLastCommunicationId()
        {
            DCDataContext db = new DCDataContext();

            return (from a in db.Tbl_Messenger_Communications
                    orderby a.Fld_Communication_ID descending
                    select a.Fld_Communication_ID).FirstOrDefault();
        }

        //تابعی برای بازگشت آخرین آی دی ثبت شده در جدول کامونیکیشن یوزر چون باید دستی افزوده شود
        public static long getLastCommunicationUserId()
        {
            DCDataContext db = new DCDataContext();

            return (from a in db.Tbl_Messenger_CommunicationUsers
                    orderby a.Fld_CommunicationUser_ID descending
                    select a.Fld_CommunicationUser_ID).FirstOrDefault();
        }

        
    }
}