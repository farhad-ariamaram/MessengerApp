USE [master]
GO
/****** Object:  Database [MessengerDB]    Script Date: 4/25/2021 8:36:56 AM ******/
CREATE DATABASE [MessengerDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MessengerDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MessengerDB.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MessengerDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MessengerDB_log.ldf' , SIZE = 1792KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MessengerDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MessengerDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MessengerDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MessengerDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MessengerDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MessengerDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MessengerDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MessengerDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MessengerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MessengerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MessengerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MessengerDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MessengerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MessengerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MessengerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MessengerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MessengerDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MessengerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MessengerDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MessengerDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MessengerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MessengerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MessengerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MessengerDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MessengerDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MessengerDB] SET  MULTI_USER 
GO
ALTER DATABASE [MessengerDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MessengerDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MessengerDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MessengerDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MessengerDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MessengerDB', N'ON'
GO
USE [MessengerDB]
GO
/****** Object:  UserDefinedFunction [dbo].[Fu_GetCurrentDateTime]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fu_GetCurrentDateTime]()
RETURNS datetime
AS
BEGIN

	DECLARE @Result datetime


	SELECT @Result = getdate()


	RETURN @Result

END

GO
/****** Object:  Table [dbo].[Tbl_Messenger_Attachment]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_Attachment](
	[Fld_Attachment_ID] [bigint] NOT NULL,
	[Fld_Attachment_FileName] [nvarchar](250) NOT NULL,
	[Fld_Attachment_FileNameOrginal] [nvarchar](250) NOT NULL,
	[Fld_Attachment_ContentType] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Tbl_Attachment] PRIMARY KEY CLUSTERED 
(
	[Fld_Attachment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Messenger_Communication]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_Communication](
	[Fld_Communication_ID] [bigint] NOT NULL,
	[Fld_Communication_Name] [nvarchar](200) NOT NULL,
	[Fld_CommunicationType_ID] [int] NOT NULL,
 CONSTRAINT [PK_Tbl_Messenger_Communication] PRIMARY KEY CLUSTERED 
(
	[Fld_Communication_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Messenger_CommunicationType]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_CommunicationType](
	[Fld_CommunicationType_ID] [int] NOT NULL,
	[Fld_CommunicationType_Text] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Tbl_Messenger_CommunicationType] PRIMARY KEY CLUSTERED 
(
	[Fld_CommunicationType_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Messenger_CommunicationUser]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_CommunicationUser](
	[Fld_CommunicationUser_ID] [bigint] NOT NULL,
	[Fld_Communication_ID] [bigint] NOT NULL,
	[Fld_User_ID] [bigint] NOT NULL,
	[Fld_LastSeenID] [bigint] NULL,
	[Fld_LastSeenDateTime] [datetime] NOT NULL,
	[Fld_IsTop] [bit] NOT NULL,
 CONSTRAINT [PK_Tbl_Messenger_CommunicationUser] PRIMARY KEY CLUSTERED 
(
	[Fld_CommunicationUser_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Messenger_Joined]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_Joined](
	[Fld_Messenger_Joined_ID] [int] NOT NULL,
	[Fld_Messenger_Joined_Text] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Tbl__Messenger_Joined] PRIMARY KEY CLUSTERED 
(
	[Fld_Messenger_Joined_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Messenger_Message]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_Message](
	[Fld_Message_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Fld_Communication_ID] [bigint] NOT NULL,
	[Fld_Attachment_ID] [bigint] NULL,
	[Fld_Message_ReplayID] [bigint] NULL,
	[Fld_Message_SenderID] [bigint] NOT NULL,
	[Fld_Message_SendDateTime] [datetime] NOT NULL,
	[Fld_Message_Text] [nvarchar](2000) NULL,
	[Fld_Message_Immediate] [bit] NOT NULL,
	[Fld_Messenger_Joined_ID] [int] NULL,
	[Fld_Messenger_Joined_Value] [nvarchar](18) NULL,
 CONSTRAINT [PK_Tbl_Message] PRIMARY KEY CLUSTERED 
(
	[Fld_Message_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tbl_Messenger_User]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Messenger_User](
	[Fld_User_ID] [bigint] NOT NULL,
	[Fld_User_Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Tbl_User] PRIMARY KEY CLUSTERED 
(
	[Fld_User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Tbl_Messenger_Attachment] ([Fld_Attachment_ID], [Fld_Attachment_FileName], [Fld_Attachment_FileNameOrginal], [Fld_Attachment_ContentType]) VALUES (1, N'12345678', N'foo.txt', N'txt                                                                                                 ')
INSERT [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID], [Fld_Communication_Name], [Fld_CommunicationType_ID]) VALUES (1, N'user2', 1)
INSERT [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID], [Fld_Communication_Name], [Fld_CommunicationType_ID]) VALUES (2, N'1To3', 1)
INSERT [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID], [Fld_Communication_Name], [Fld_CommunicationType_ID]) VALUES (3, N'1To4', 1)
INSERT [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID], [Fld_Communication_Name], [Fld_CommunicationType_ID]) VALUES (4, N'1To5', 1)
INSERT [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID], [Fld_Communication_Name], [Fld_CommunicationType_ID]) VALUES (5, N'1To6', 1)
INSERT [dbo].[Tbl_Messenger_CommunicationType] ([Fld_CommunicationType_ID], [Fld_CommunicationType_Text]) VALUES (1, N'double')
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (1, 1, 1, 14, CAST(N'2021-03-03 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (2, 1, 2, 40, CAST(N'2021-03-03 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (3, 2, 1, 0, CAST(N'2021-04-19 12:02:01.437' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (4, 2, 3, 0, CAST(N'2021-04-19 12:02:01.440' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (5, 3, 1, 0, CAST(N'2021-04-19 12:02:01.463' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (6, 3, 4, 0, CAST(N'2021-04-19 12:02:01.467' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (7, 4, 1, 0, CAST(N'2021-04-19 12:02:01.480' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (8, 4, 5, 0, CAST(N'2021-04-19 12:02:01.483' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (9, 5, 1, 0, CAST(N'2021-04-19 12:02:01.500' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_CommunicationUser] ([Fld_CommunicationUser_ID], [Fld_Communication_ID], [Fld_User_ID], [Fld_LastSeenID], [Fld_LastSeenDateTime], [Fld_IsTop]) VALUES (10, 5, 6, 0, CAST(N'2021-04-19 12:02:01.503' AS DateTime), 0)
INSERT [dbo].[Tbl_Messenger_Joined] ([Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Text]) VALUES (1, N'درخواست خرید')
SET IDENTITY_INSERT [dbo].[Tbl_Messenger_Message] ON 

INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (1, 1, 1, NULL, 1, CAST(N'2021-03-03 00:00:00.000' AS DateTime), N'1', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (4, 1, NULL, 1, 1, CAST(N'2021-03-03 01:00:00.000' AS DateTime), N'2', 0, 1, N'1')
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (5, 1, 1, NULL, 2, CAST(N'2021-03-03 02:00:00.000' AS DateTime), N'3', 1, 1, N'1')
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (6, 1, NULL, NULL, 1, CAST(N'2021-03-03 03:00:00.000' AS DateTime), N'4', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (7, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'5', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (8, 1, NULL, NULL, 2, CAST(N'2021-03-03 05:00:00.000' AS DateTime), N'6', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (9, 1, 1, NULL, 1, CAST(N'2021-03-03 06:00:00.000' AS DateTime), N'7reply', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (10, 1, 1, 9, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'10real', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (11, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'9', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (12, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'10', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (13, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'11', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (14, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'12', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (15, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'13', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (16, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'14', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (17, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'15', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (18, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'16', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (19, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'17', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (20, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'18', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (21, 1, NULL, NULL, 1, CAST(N'2021-03-03 03:00:00.000' AS DateTime), N'19', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (22, 1, NULL, 21, 2, CAST(N'2021-03-03 05:00:00.000' AS DateTime), N'20', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (23, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'21', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (24, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'22', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (25, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'23', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (26, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'24', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (27, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'25', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (28, 1, 1, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'26', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (29, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'27', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'28', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (31, 1, NULL, 25, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'29', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (32, 1, NULL, 25, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'30', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (33, 1, NULL, 20, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'31', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (34, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'32', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (35, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'33', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (36, 1, NULL, 1, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'34', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (37, 1, NULL, 1, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'35', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (38, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'36', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (39, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'37', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (40, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'38', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (41, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'39', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (42, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'40', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (43, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'41', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (44, 1, NULL, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'42', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (45, 1, NULL, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'43', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (46, 1, 1, NULL, 2, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'44', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (47, 1, 1, NULL, 1, CAST(N'2021-03-03 04:00:00.000' AS DateTime), N'45', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (234, 1, NULL, 16, 2, CAST(N'2021-03-18 15:50:00.417' AS DateTime), N'hello
', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (238, 1, NULL, 1, 2, CAST(N'2021-03-18 15:50:23.540' AS DateTime), N'allow
', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (239, 1, NULL, NULL, 2, CAST(N'2021-03-18 15:51:19.300' AS DateTime), N's', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30062, 1, NULL, NULL, 1, CAST(N'2021-03-03 00:00:00.000' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30063, 1, NULL, NULL, 1, CAST(N'2021-03-03 00:00:00.000' AS DateTime), N'dd', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30064, 1, NULL, NULL, 1, CAST(N'2021-03-03 00:00:00.000' AS DateTime), N'dd', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30140, 1, NULL, NULL, 1, CAST(N'2021-04-18 16:39:51.017' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30141, 1, NULL, NULL, 1, CAST(N'2021-04-18 16:40:14.047' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30142, 1, NULL, NULL, 1, CAST(N'2021-04-18 16:40:31.327' AS DateTime), N'', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30143, 1, NULL, 30142, 1, CAST(N'2021-04-18 16:40:34.377' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30144, 1, NULL, 30143, 1, CAST(N'2021-04-18 16:40:39.450' AS DateTime), N'', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30145, 1, NULL, 239, 1, CAST(N'2021-04-18 16:40:52.200' AS DateTime), N'', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30146, 1, NULL, 1, 1, CAST(N'2021-04-19 08:25:22.990' AS DateTime), N'', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30147, 1, NULL, NULL, 1, CAST(N'2021-04-19 08:25:30.063' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30148, 1, NULL, NULL, 1, CAST(N'2021-04-19 08:25:42.537' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30149, 1, NULL, 30148, 1, CAST(N'2021-04-19 08:25:44.863' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30150, 1, NULL, NULL, 1, CAST(N'2021-04-19 08:25:48.953' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30151, 1, NULL, 4, 1, CAST(N'2021-04-19 08:29:20.243' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30152, 1, NULL, 239, 1, CAST(N'2021-04-19 08:29:26.193' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30153, 1, NULL, NULL, 1, CAST(N'2021-04-19 08:40:13.537' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30154, 1, NULL, 46, 1, CAST(N'2021-04-19 08:40:23.837' AS DateTime), N'', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30155, 1, NULL, NULL, 1, CAST(N'2021-04-19 11:10:50.353' AS DateTime), N'1', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30156, 1, NULL, NULL, 1, CAST(N'2021-04-19 11:11:57.460' AS DateTime), N'2', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30164, 2, NULL, NULL, 1, CAST(N'2021-04-19 12:02:01.450' AS DateTime), N'1', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30165, 3, NULL, NULL, 1, CAST(N'2021-04-19 12:02:01.473' AS DateTime), N'1', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30166, 4, NULL, NULL, 1, CAST(N'2021-04-19 12:02:01.493' AS DateTime), N'1', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30167, 5, NULL, NULL, 1, CAST(N'2021-04-19 12:02:01.510' AS DateTime), N'1', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30168, 2, NULL, NULL, 1, CAST(N'2021-04-19 13:10:40.090' AS DateTime), N'1', 0, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30169, 5, 1, NULL, 1, CAST(N'2021-04-19 13:16:25.017' AS DateTime), N'1', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30170, 4, 1, NULL, 1, CAST(N'2021-04-19 13:16:25.047' AS DateTime), N'1', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30171, 3, 1, NULL, 1, CAST(N'2021-04-19 13:16:25.073' AS DateTime), N'1', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30172, 2, 1, NULL, 1, CAST(N'2021-04-19 13:16:25.093' AS DateTime), N'1', 1, NULL, NULL)
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30173, 5, NULL, NULL, 1, CAST(N'2021-04-19 13:18:53.467' AS DateTime), N'2', 0, 1, N'1')
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30174, 4, NULL, NULL, 1, CAST(N'2021-04-19 13:18:53.490' AS DateTime), N'2', 0, 1, N'1')
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30175, 3, NULL, NULL, 1, CAST(N'2021-04-19 13:18:53.510' AS DateTime), N'2', 0, 1, N'1')
INSERT [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID], [Fld_Communication_ID], [Fld_Attachment_ID], [Fld_Message_ReplayID], [Fld_Message_SenderID], [Fld_Message_SendDateTime], [Fld_Message_Text], [Fld_Message_Immediate], [Fld_Messenger_Joined_ID], [Fld_Messenger_Joined_Value]) VALUES (30176, 2, NULL, NULL, 1, CAST(N'2021-04-19 13:18:53.530' AS DateTime), N'2', 0, 1, N'1')
SET IDENTITY_INSERT [dbo].[Tbl_Messenger_Message] OFF
INSERT [dbo].[Tbl_Messenger_User] ([Fld_User_ID], [Fld_User_Name]) VALUES (1, N'user1')
INSERT [dbo].[Tbl_Messenger_User] ([Fld_User_ID], [Fld_User_Name]) VALUES (2, N'user2')
INSERT [dbo].[Tbl_Messenger_User] ([Fld_User_ID], [Fld_User_Name]) VALUES (3, N'user3')
INSERT [dbo].[Tbl_Messenger_User] ([Fld_User_ID], [Fld_User_Name]) VALUES (4, N'user4')
INSERT [dbo].[Tbl_Messenger_User] ([Fld_User_ID], [Fld_User_Name]) VALUES (5, N'user5')
INSERT [dbo].[Tbl_Messenger_User] ([Fld_User_ID], [Fld_User_Name]) VALUES (6, N'user6')
/****** Object:  Index [IX_Tbl_Messenger_CommunicationUser]    Script Date: 4/25/2021 8:36:56 AM ******/
ALTER TABLE [dbo].[Tbl_Messenger_CommunicationUser] ADD  CONSTRAINT [IX_Tbl_Messenger_CommunicationUser] UNIQUE NONCLUSTERED 
(
	[Fld_User_ID] ASC,
	[Fld_Communication_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Messenger_CommunicationUser] ADD  CONSTRAINT [DF_Tbl_Messenger_CommunicationUser_Fld_IsTop]  DEFAULT ((0)) FOR [Fld_IsTop]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message] ADD  CONSTRAINT [DF_Tbl_Message_Fld_Message_Immediate]  DEFAULT ((0)) FOR [Fld_Message_Immediate]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Communication]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Messenger_Communication_Tbl_Messenger_CommunicationType] FOREIGN KEY([Fld_CommunicationType_ID])
REFERENCES [dbo].[Tbl_Messenger_CommunicationType] ([Fld_CommunicationType_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_Communication] CHECK CONSTRAINT [FK_Tbl_Messenger_Communication_Tbl_Messenger_CommunicationType]
GO
ALTER TABLE [dbo].[Tbl_Messenger_CommunicationUser]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Messenger_CommunicationUser_Tbl_Messenger_Communication] FOREIGN KEY([Fld_Communication_ID])
REFERENCES [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_CommunicationUser] CHECK CONSTRAINT [FK_Tbl_Messenger_CommunicationUser_Tbl_Messenger_Communication]
GO
ALTER TABLE [dbo].[Tbl_Messenger_CommunicationUser]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Messenger_CommunicationUser_Tbl_Messenger_User] FOREIGN KEY([Fld_User_ID])
REFERENCES [dbo].[Tbl_Messenger_User] ([Fld_User_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_CommunicationUser] CHECK CONSTRAINT [FK_Tbl_Messenger_CommunicationUser_Tbl_Messenger_User]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Message_Tbl_Attachment] FOREIGN KEY([Fld_Attachment_ID])
REFERENCES [dbo].[Tbl_Messenger_Attachment] ([Fld_Attachment_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message] CHECK CONSTRAINT [FK_Tbl_Message_Tbl_Attachment]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Message_Tbl_User] FOREIGN KEY([Fld_Message_SenderID])
REFERENCES [dbo].[Tbl_Messenger_User] ([Fld_User_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message] CHECK CONSTRAINT [FK_Tbl_Message_Tbl_User]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Messenger_Message_Tbl_Messenger_Communication] FOREIGN KEY([Fld_Communication_ID])
REFERENCES [dbo].[Tbl_Messenger_Communication] ([Fld_Communication_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message] CHECK CONSTRAINT [FK_Tbl_Messenger_Message_Tbl_Messenger_Communication]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Messenger_Message_Tbl_Messenger_Joined] FOREIGN KEY([Fld_Messenger_Joined_ID])
REFERENCES [dbo].[Tbl_Messenger_Joined] ([Fld_Messenger_Joined_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message] CHECK CONSTRAINT [FK_Tbl_Messenger_Message_Tbl_Messenger_Joined]
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Messenger_Message_Tbl_Messenger_Message1] FOREIGN KEY([Fld_Message_ReplayID])
REFERENCES [dbo].[Tbl_Messenger_Message] ([Fld_Message_ID])
GO
ALTER TABLE [dbo].[Tbl_Messenger_Message] CHECK CONSTRAINT [FK_Tbl_Messenger_Message_Tbl_Messenger_Message1]
GO
/****** Object:  StoredProcedure [dbo].[SelectCommunicationId]    Script Date: 4/25/2021 8:36:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectCommunicationId] @User1 bigint, @User2 bigint
AS
	select Fld_Communication_ID
	from Tbl_Messenger_CommunicationUser
	where Fld_User_ID in (@User1,@User2)
	group by Fld_Communication_ID
	Having count(Fld_User_ID) = 2

GO
USE [master]
GO
ALTER DATABASE [MessengerDB] SET  READ_WRITE 
GO
