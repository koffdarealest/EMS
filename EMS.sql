USE [master]
GO
/****** Object:  Database [emstest]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE DATABASE [emstest]

GO
ALTER DATABASE [emstest] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [emstest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [emstest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [emstest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [emstest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [emstest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [emstest] SET ARITHABORT OFF 
GO
ALTER DATABASE [emstest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [emstest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [emstest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [emstest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [emstest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [emstest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [emstest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [emstest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [emstest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [emstest] SET  ENABLE_BROKER 
GO
ALTER DATABASE [emstest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [emstest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [emstest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [emstest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [emstest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [emstest] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [emstest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [emstest] SET RECOVERY FULL 
GO
ALTER DATABASE [emstest] SET  MULTI_USER 
GO
ALTER DATABASE [emstest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [emstest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [emstest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [emstest] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [emstest] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [emstest] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'emstest', N'ON'
GO
ALTER DATABASE [emstest] SET QUERY_STORE = ON
GO
ALTER DATABASE [emstest] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [emstest]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActivityLogs]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLogs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Detail] [nvarchar](max) NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_ActivityLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendances]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendances](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CheckIn] [datetime2](7) NULL,
	[CheckOut] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
	[CheckInImage] [nvarchar](max) NULL,
	[CheckOutImage] [nvarchar](max) NULL,
 CONSTRAINT [PK_Attendances] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bonuses]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bonuses](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IsPenalty] [bit] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Reason] [nvarchar](max) NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_Bonuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveBalances]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveBalances](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Year] [int] NOT NULL,
	[RemainingDay] [int] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
	[RemainingSickDay] [int] NOT NULL,
 CONSTRAINT [PK_LeaveBalances] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveRequests]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveRequests](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Type] [int] NOT NULL,
	[Reason] [nvarchar](max) NULL,
	[From] [datetime2](7) NOT NULL,
	[To] [datetime2](7) NOT NULL,
	[TotalDays] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[ApprovedBy] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_LeaveRequests] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationRecipients]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationRecipients](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IsRead] [bit] NOT NULL,
	[NotificationId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_NotificationRecipients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[DepartmentId] [bigint] NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
	[UserId1] [bigint] NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salaries]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salaries](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Basic] [decimal](18, 2) NOT NULL,
	[Allowance] [decimal](18, 2) NOT NULL,
	[EffectiveAt] [datetime2](7) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_Salaries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalaryPayments]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryPayments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TotalSalary] [decimal](18, 2) NOT NULL,
	[TotalBonus] [decimal](18, 2) NOT NULL,
	[TotalPaid] [decimal](18, 2) NOT NULL,
	[PaidAt] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[UserId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
	[TotalPenalty] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_SalaryPayments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAuths]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAuths](
	[UserId] [bigint] NOT NULL,
	[Username] [nvarchar](max) NOT NULL,
	[PasswordHash] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_UserAuths] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/29/2025 9:16:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Role] [int] NOT NULL,
	[Fullname] [nvarchar](max) NOT NULL,
	[Birth] [date] NOT NULL,
	[Gender] [int] NOT NULL,
	[Address] [nvarchar](max) NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[Duty] [int] NOT NULL,
	[JoinedAt] [date] NOT NULL,
	[Avatar] [nvarchar](max) NULL,
	[DepartmentId] [bigint] NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[DeletedAt] [datetime2](7) NULL,
	[CreatedBy] [bigint] NULL,
	[UpdatedBy] [bigint] NULL,
	[DeletedBy] [bigint] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250227083250_InitialCreate', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250227090448_AddUserAuth', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250227144102_AddNullableAudit', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250228091632_AddAutoAudit', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250306062709_AddCheckPhotos', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250308073928_UpdateLeaveRequestTotalDays', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250310040300_UpdateSickDay', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250313183042_AddNullablePaidTime', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250314184657_AddTotalPenalty', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250320064955_AddNullableDepartmentNotification', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250321050337_RenameSenderIdField', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250321054725_FixedUserIdForeignKey', N'8.0.13')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20250321060550_FixMigration', N'8.0.13')
GO
SET IDENTITY_INSERT [dbo].[ActivityLogs] ON 

INSERT [dbo].[ActivityLogs] ([Id], [Detail], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (1, N'Create user 0', 1, 0, CAST(N'2025-03-24T09:15:01.0235784' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[ActivityLogs] ([Id], [Detail], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, N'Create user 0', 1, 0, CAST(N'2025-03-24T09:17:59.1182062' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[ActivityLogs] ([Id], [Detail], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, N'Edit user 9', 1, 0, CAST(N'2025-03-24T09:19:39.3603637' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[ActivityLogs] ([Id], [Detail], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, N'Create user 10019', 1, 0, CAST(N'2025-03-24T09:22:49.7051771' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[ActivityLogs] ([Id], [Detail], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (5, N'Edit user 2', 1, 0, CAST(N'2025-03-28T22:48:38.1282277' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[ActivityLogs] ([Id], [Detail], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, N'Edit user 1', 1, 0, CAST(N'2025-03-28T22:48:51.1668811' AS DateTime2), NULL, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ActivityLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[Attendances] ON 

INSERT [dbo].[Attendances] ([Id], [CheckIn], [CheckOut], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [CheckInImage], [CheckOutImage]) VALUES (1, CAST(N'2025-03-07T08:55:34.0480533' AS DateTime2), CAST(N'2025-03-07T09:15:34.2484929' AS DateTime2), 0, 1, 0, CAST(N'2025-03-07T08:55:34.1879686' AS DateTime2), CAST(N'2025-03-07T09:15:34.3230922' AS DateTime2), NULL, 1, 1, NULL, N'https://prn222ems.blob.core.windows.net/ems-check/1_20250307_015514.jpg', N'https://prn222ems.blob.core.windows.net/ems-check/1_20250307_021533.jpg')
INSERT [dbo].[Attendances] ([Id], [CheckIn], [CheckOut], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [CheckInImage], [CheckOutImage]) VALUES (2, CAST(N'2025-03-07T09:27:15.3514273' AS DateTime2), CAST(N'2025-03-07T09:27:33.6377848' AS DateTime2), 0, 2, 0, CAST(N'2025-03-07T09:27:15.4057295' AS DateTime2), CAST(N'2025-03-07T09:27:33.6680859' AS DateTime2), NULL, 2, 2, NULL, N'https://prn222ems.blob.core.windows.net/ems-check/2_20250307_022714.jpg', N'https://prn222ems.blob.core.windows.net/ems-check/2_20250307_022733.jpg')
INSERT [dbo].[Attendances] ([Id], [CheckIn], [CheckOut], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [CheckInImage], [CheckOutImage]) VALUES (3, CAST(N'2025-03-07T09:30:14.7410000' AS DateTime2), CAST(N'2025-03-07T09:30:50.6180000' AS DateTime2), 0, 4, 0, CAST(N'2025-03-07T09:30:14.8559512' AS DateTime2), CAST(N'2025-03-08T14:00:01.6014924' AS DateTime2), NULL, 4, 1, NULL, N'https://prn222ems.blob.core.windows.net/ems-check/4_20250307_023014.jpg', N'https://prn222ems.blob.core.windows.net/ems-check/4_20250307_023050.jpg')
INSERT [dbo].[Attendances] ([Id], [CheckIn], [CheckOut], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [CheckInImage], [CheckOutImage]) VALUES (5, CAST(N'2025-03-07T11:46:40.6480000' AS DateTime2), CAST(N'2025-03-07T13:57:25.5430000' AS DateTime2), 0, 13, 0, CAST(N'2025-03-07T11:46:40.6506272' AS DateTime2), CAST(N'2025-03-08T14:01:28.0538420' AS DateTime2), NULL, 13, 1, NULL, N'https://prn222ems.blob.core.windows.net/ems-check/13_20250307_044640.jpg', N'https://prn222ems.blob.core.windows.net/ems-check/13_20250307_044824.jpg')
INSERT [dbo].[Attendances] ([Id], [CheckIn], [CheckOut], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [CheckInImage], [CheckOutImage]) VALUES (6, CAST(N'2025-03-25T01:06:06.2484553' AS DateTime2), CAST(N'2025-03-25T01:06:51.0600403' AS DateTime2), 0, 11, 0, CAST(N'2025-03-25T01:06:06.3076202' AS DateTime2), CAST(N'2025-03-25T01:06:51.0879863' AS DateTime2), NULL, 11, 11, NULL, N'https://prn222ems.blob.core.windows.net/ems-check/11_20250324_180605.jpg', N'https://prn222ems.blob.core.windows.net/ems-check/11_20250324_180650.jpg')
INSERT [dbo].[Attendances] ([Id], [CheckIn], [CheckOut], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [CheckInImage], [CheckOutImage]) VALUES (7, CAST(N'2025-03-29T08:41:42.8743200' AS DateTime2), CAST(N'2025-03-29T08:41:48.0763504' AS DateTime2), 0, 2, 0, CAST(N'2025-03-29T08:41:42.8818384' AS DateTime2), CAST(N'2025-03-29T08:41:48.0928564' AS DateTime2), NULL, 2, 2, NULL, N'https://prn222ems.blob.core.windows.net/ems-check/2_20250329_014142.jpg', N'https://prn222ems.blob.core.windows.net/ems-check/2_20250329_014147.jpg')
SET IDENTITY_INSERT [dbo].[Attendances] OFF
GO
SET IDENTITY_INSERT [dbo].[Bonuses] ON 

INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (1, 0, CAST(70.00 AS Decimal(18, 2)), N'Goodz', 13, 0, CAST(N'2025-03-05T15:54:39.8449003' AS DateTime2), CAST(N'2025-03-06T01:43:20.4534750' AS DateTime2), NULL, 1, 1, NULL)
INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, 1, CAST(400.00 AS Decimal(18, 2)), N'Late
', 15, 0, CAST(N'2025-03-06T00:34:57.8499465' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, 0, CAST(100.00 AS Decimal(18, 2)), N'Soon', 8, 0, CAST(N'2025-03-06T00:40:43.5859641' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, 1, CAST(23.00 AS Decimal(18, 2)), N'a', 13, 1, CAST(N'2025-03-06T02:07:49.8310019' AS DateTime2), CAST(N'2025-03-06T02:09:17.2295743' AS DateTime2), CAST(N'2025-03-06T02:09:17.1881263' AS DateTime2), 1, 1, 1)
INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (5, 1, CAST(4000.00 AS Decimal(18, 2)), N'an', 13, 1, CAST(N'2025-03-06T02:11:45.8055199' AS DateTime2), CAST(N'2025-03-06T02:11:52.0880058' AS DateTime2), CAST(N'2025-03-06T02:11:52.0866311' AS DateTime2), 1, 1, 1)
INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, 1, CAST(100.00 AS Decimal(18, 2)), N'khong lam viec', 11, 0, CAST(N'2025-03-08T01:30:34.3420128' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Bonuses] ([Id], [IsPenalty], [Amount], [Reason], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (7, 0, CAST(300.00 AS Decimal(18, 2)), N'lam viec tot', 2, 0, CAST(N'2025-03-29T08:34:49.9055609' AS DateTime2), NULL, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Bonuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([Id], [Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, N'Sales', 0, CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), NULL, 1, NULL, NULL)
INSERT [dbo].[Departments] ([Id], [Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, N'Human Resources', 0, CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), NULL, 1, NULL, NULL)
INSERT [dbo].[Departments] ([Id], [Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, N'Accounting', 0, CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), NULL, 1, NULL, NULL)
INSERT [dbo].[Departments] ([Id], [Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (5, N'IT', 0, CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), NULL, 1, NULL, NULL)
INSERT [dbo].[Departments] ([Id], [Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, N'Marketing', 0, CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), CAST(N'2025-02-27T21:43:17.5267943' AS DateTime2), NULL, 1, NULL, NULL)
INSERT [dbo].[Departments] ([Id], [Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (7, N'Customer Service', 0, CAST(N'2025-03-03T09:36:41.8825925' AS DateTime2), NULL, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveBalances] ON 

INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (1, 2025, 12, 17, 0, CAST(N'2025-03-10T11:15:22.7210205' AS DateTime2), NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (2, 2025, 12, 2, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (4, 2025, 12, 3, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (5, 2025, 12, 4, 0, NULL, NULL, NULL, 1, NULL, NULL, 27)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (7, 2025, 12, 6, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (8, 2025, 12, 7, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (9, 2025, 12, 8, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (10, 2025, 12, 9, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (12, 2025, 12, 10, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (13, 2025, 12, 11, 0, NULL, NULL, NULL, 1, NULL, NULL, 28)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (14, 2025, 12, 12, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (15, 2025, 12, 13, 0, NULL, CAST(N'2025-03-10T16:05:21.2388454' AS DateTime2), NULL, 1, 1, NULL, 27)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (16, 2025, 12, 14, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (17, 2025, 12, 15, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (18, 2025, 12, 1, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (19, 2025, 12, 16, 0, NULL, NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (10002, 2025, 12, 10017, 0, CAST(N'2025-03-24T09:15:00.5086933' AS DateTime2), NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (10003, 2025, 12, 10018, 0, CAST(N'2025-03-24T09:17:45.8535856' AS DateTime2), NULL, NULL, 1, NULL, NULL, 30)
INSERT [dbo].[LeaveBalances] ([Id], [Year], [RemainingDay], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [RemainingSickDay]) VALUES (10004, 2025, 12, 10019, 0, CAST(N'2025-03-24T09:22:49.3844678' AS DateTime2), NULL, NULL, 1, NULL, NULL, 30)
SET IDENTITY_INSERT [dbo].[LeaveBalances] OFF
GO
SET IDENTITY_INSERT [dbo].[LeaveRequests] ON 

INSERT [dbo].[LeaveRequests] ([Id], [Type], [Reason], [From], [To], [TotalDays], [Status], [ApprovedBy], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, 1, N'Nghi om', CAST(N'2025-03-08T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-09T23:59:59.0000000' AS DateTime2), 2, 2, NULL, 11, 0, CAST(N'2025-03-08T23:19:29.0928648' AS DateTime2), CAST(N'2025-03-10T10:30:52.6948714' AS DateTime2), NULL, 11, 1, NULL)
INSERT [dbo].[LeaveRequests] ([Id], [Type], [Reason], [From], [To], [TotalDays], [Status], [ApprovedBy], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, 1, N'dau bung', CAST(N'2025-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-12T23:59:59.0000000' AS DateTime2), 3, 1, NULL, 4, 0, CAST(N'2025-03-10T10:35:04.5099860' AS DateTime2), CAST(N'2025-03-10T10:35:11.3769442' AS DateTime2), NULL, 4, 1, NULL)
INSERT [dbo].[LeaveRequests] ([Id], [Type], [Reason], [From], [To], [TotalDays], [Status], [ApprovedBy], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, 1, N'sick', CAST(N'2025-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-11T23:59:59.0000000' AS DateTime2), 2, 1, NULL, 16, 0, CAST(N'2025-03-10T15:38:06.4498357' AS DateTime2), CAST(N'2025-03-10T15:38:19.7744854' AS DateTime2), NULL, 16, 1, NULL)
INSERT [dbo].[LeaveRequests] ([Id], [Type], [Reason], [From], [To], [TotalDays], [Status], [ApprovedBy], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (5, 1, N'om', CAST(N'2025-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-13T23:59:59.0000000' AS DateTime2), 4, 1, NULL, 17, 0, CAST(N'2025-03-10T15:38:59.6146978' AS DateTime2), CAST(N'2025-03-10T15:39:09.4514384' AS DateTime2), NULL, 17, 1, NULL)
INSERT [dbo].[LeaveRequests] ([Id], [Type], [Reason], [From], [To], [TotalDays], [Status], [ApprovedBy], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, 1, N'om', CAST(N'2025-03-10T00:00:00.0000000' AS DateTime2), CAST(N'2025-03-12T23:59:59.0000000' AS DateTime2), 3, 1, NULL, 13, 0, CAST(N'2025-03-10T16:02:43.3301519' AS DateTime2), CAST(N'2025-03-10T16:05:21.4436167' AS DateTime2), NULL, 13, 1, NULL)
SET IDENTITY_INSERT [dbo].[LeaveRequests] OFF
GO
SET IDENTITY_INSERT [dbo].[NotificationRecipients] ON 

INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (1, 1, 1, 2, 0, CAST(N'2025-03-21T10:51:00.2084363' AS DateTime2), CAST(N'2025-03-21T10:51:02.7510113' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, 1, 1, 3, 0, CAST(N'2025-03-21T10:51:00.2095326' AS DateTime2), CAST(N'2025-03-21T10:59:09.9464198' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, 0, 1, 4, 0, CAST(N'2025-03-21T10:51:00.2095340' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, 1, 1, 6, 0, CAST(N'2025-03-21T10:51:00.2095342' AS DateTime2), CAST(N'2025-03-21T22:57:56.3317767' AS DateTime2), NULL, 1, 6, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (5, 0, 1, 7, 0, CAST(N'2025-03-21T10:51:00.2095344' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, 0, 1, 8, 0, CAST(N'2025-03-21T10:51:00.2095346' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (7, 0, 1, 9, 0, CAST(N'2025-03-21T10:51:00.2095348' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (8, 0, 1, 10, 0, CAST(N'2025-03-21T10:51:00.2095350' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (9, 1, 1, 11, 0, CAST(N'2025-03-21T10:51:00.2095351' AS DateTime2), CAST(N'2025-03-21T10:51:32.0787805' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (10, 1, 1, 13, 0, CAST(N'2025-03-21T10:51:00.2095353' AS DateTime2), CAST(N'2025-03-21T10:54:35.6634243' AS DateTime2), NULL, 1, 13, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (11, 0, 1, 14, 0, CAST(N'2025-03-21T10:51:00.2095362' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (12, 0, 1, 15, 0, CAST(N'2025-03-21T10:51:00.2095365' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (13, 0, 1, 16, 0, CAST(N'2025-03-21T10:51:00.2095367' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (14, 0, 1, 17, 0, CAST(N'2025-03-21T10:51:00.2095368' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (15, 1, 2, 2, 0, CAST(N'2025-03-21T23:18:35.2827364' AS DateTime2), CAST(N'2025-03-21T23:25:55.0265524' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (16, 1, 2, 3, 0, CAST(N'2025-03-21T23:18:35.2836500' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982001' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (17, 0, 2, 4, 0, CAST(N'2025-03-21T23:18:35.2836509' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (18, 0, 2, 6, 0, CAST(N'2025-03-21T23:18:35.2836511' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (19, 0, 2, 7, 0, CAST(N'2025-03-21T23:18:35.2836514' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (20, 0, 2, 8, 0, CAST(N'2025-03-21T23:18:35.2836516' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (21, 0, 2, 9, 0, CAST(N'2025-03-21T23:18:35.2836519' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (22, 0, 2, 10, 0, CAST(N'2025-03-21T23:18:35.2836531' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (23, 1, 2, 11, 0, CAST(N'2025-03-21T23:18:35.2836533' AS DateTime2), CAST(N'2025-03-21T23:25:39.7796818' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (24, 0, 2, 13, 0, CAST(N'2025-03-21T23:18:35.2836535' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (25, 0, 2, 14, 0, CAST(N'2025-03-21T23:18:35.2836537' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (26, 0, 2, 15, 0, CAST(N'2025-03-21T23:18:35.2836538' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (27, 0, 2, 16, 0, CAST(N'2025-03-21T23:18:35.2836540' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (28, 0, 2, 17, 0, CAST(N'2025-03-21T23:18:35.2836542' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (29, 1, 3, 2, 0, CAST(N'2025-03-21T23:28:23.1930299' AS DateTime2), CAST(N'2025-03-21T23:28:32.7127656' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (30, 1, 3, 3, 0, CAST(N'2025-03-21T23:28:23.1941491' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982045' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (31, 0, 3, 4, 0, CAST(N'2025-03-21T23:28:23.1941498' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (32, 1, 4, 2, 0, CAST(N'2025-03-21T23:31:13.7155492' AS DateTime2), CAST(N'2025-03-21T23:31:20.8809830' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (33, 1, 4, 3, 0, CAST(N'2025-03-21T23:31:13.7155597' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982049' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (34, 0, 4, 4, 0, CAST(N'2025-03-21T23:31:13.7155602' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (35, 1, 5, 2, 0, CAST(N'2025-03-21T23:32:20.2960066' AS DateTime2), CAST(N'2025-03-21T23:32:33.8087345' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (36, 1, 5, 3, 0, CAST(N'2025-03-21T23:32:20.2970741' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982052' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (37, 0, 5, 4, 0, CAST(N'2025-03-21T23:32:20.2970749' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (38, 1, 6, 2, 0, CAST(N'2025-03-21T23:41:20.4316415' AS DateTime2), CAST(N'2025-03-21T23:52:37.4092417' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (39, 1, 6, 3, 0, CAST(N'2025-03-21T23:41:20.4327700' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982061' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (40, 0, 6, 4, 0, CAST(N'2025-03-21T23:41:20.4327719' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (41, 1, 7, 2, 0, CAST(N'2025-03-21T23:51:50.6866199' AS DateTime2), CAST(N'2025-03-21T23:52:37.4106749' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (42, 1, 7, 3, 0, CAST(N'2025-03-21T23:51:50.6866281' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982067' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (43, 0, 7, 4, 0, CAST(N'2025-03-21T23:51:50.6866284' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (44, 1, 8, 2, 0, CAST(N'2025-03-21T23:52:26.6741965' AS DateTime2), CAST(N'2025-03-21T23:52:37.4106761' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (45, 1, 8, 3, 0, CAST(N'2025-03-21T23:52:26.6742354' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982072' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (46, 0, 8, 4, 0, CAST(N'2025-03-21T23:52:26.6742359' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (47, 0, 8, 6, 0, CAST(N'2025-03-21T23:52:26.6742362' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (48, 0, 8, 7, 0, CAST(N'2025-03-21T23:52:26.6742374' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (49, 0, 8, 8, 0, CAST(N'2025-03-21T23:52:26.6742378' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (50, 0, 8, 9, 0, CAST(N'2025-03-21T23:52:26.6742380' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (51, 0, 8, 10, 0, CAST(N'2025-03-21T23:52:26.6742383' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (52, 1, 8, 11, 0, CAST(N'2025-03-21T23:52:26.6742385' AS DateTime2), CAST(N'2025-03-25T01:05:39.0119180' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (53, 0, 8, 13, 0, CAST(N'2025-03-21T23:52:26.6742388' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (54, 0, 8, 14, 0, CAST(N'2025-03-21T23:52:26.6742390' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (55, 0, 8, 15, 0, CAST(N'2025-03-21T23:52:26.6742393' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (56, 0, 8, 16, 0, CAST(N'2025-03-21T23:52:26.6742395' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (57, 0, 8, 17, 0, CAST(N'2025-03-21T23:52:26.6742398' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (58, 1, 9, 2, 0, CAST(N'2025-03-21T23:52:49.6539540' AS DateTime2), CAST(N'2025-03-21T23:52:52.8030128' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (59, 1, 9, 3, 0, CAST(N'2025-03-21T23:52:49.6539620' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982083' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (60, 0, 9, 4, 0, CAST(N'2025-03-21T23:52:49.6539623' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (61, 0, 9, 6, 0, CAST(N'2025-03-21T23:52:49.6539625' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (62, 0, 9, 7, 0, CAST(N'2025-03-21T23:52:49.6539639' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (63, 0, 9, 8, 0, CAST(N'2025-03-21T23:52:49.6539641' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (64, 0, 9, 9, 0, CAST(N'2025-03-21T23:52:49.6539647' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (65, 0, 9, 10, 0, CAST(N'2025-03-21T23:52:49.6539661' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (66, 1, 9, 11, 0, CAST(N'2025-03-21T23:52:49.6539663' AS DateTime2), CAST(N'2025-03-25T01:05:39.0180603' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (67, 0, 9, 13, 0, CAST(N'2025-03-21T23:52:49.6539665' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (68, 0, 9, 14, 0, CAST(N'2025-03-21T23:52:49.6539667' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (69, 0, 9, 15, 0, CAST(N'2025-03-21T23:52:49.6539669' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (70, 0, 9, 16, 0, CAST(N'2025-03-21T23:52:49.6539671' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (71, 0, 9, 17, 0, CAST(N'2025-03-21T23:52:49.6539673' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (72, 1, 10, 2, 0, CAST(N'2025-03-21T23:55:46.1742980' AS DateTime2), CAST(N'2025-03-21T23:56:20.9934479' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (73, 1, 10, 3, 0, CAST(N'2025-03-21T23:55:46.1755422' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982086' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (74, 0, 10, 4, 0, CAST(N'2025-03-21T23:55:46.1755434' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (75, 1, 11, 2, 0, CAST(N'2025-03-21T23:56:18.8135076' AS DateTime2), CAST(N'2025-03-21T23:56:20.9949976' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (76, 1, 11, 3, 0, CAST(N'2025-03-21T23:56:18.8135152' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982089' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (77, 0, 11, 4, 0, CAST(N'2025-03-21T23:56:18.8135155' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (78, 0, 11, 6, 0, CAST(N'2025-03-21T23:56:18.8135157' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (79, 0, 11, 7, 0, CAST(N'2025-03-21T23:56:18.8135159' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (80, 0, 11, 8, 0, CAST(N'2025-03-21T23:56:18.8135161' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (81, 0, 11, 9, 0, CAST(N'2025-03-21T23:56:18.8135163' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (82, 0, 11, 10, 0, CAST(N'2025-03-21T23:56:18.8135165' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (83, 1, 11, 11, 0, CAST(N'2025-03-21T23:56:18.8135173' AS DateTime2), CAST(N'2025-03-25T01:05:39.0180642' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (84, 0, 11, 13, 0, CAST(N'2025-03-21T23:56:18.8135175' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (85, 0, 11, 14, 0, CAST(N'2025-03-21T23:56:18.8135177' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (86, 0, 11, 15, 0, CAST(N'2025-03-21T23:56:18.8135179' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (87, 0, 11, 16, 0, CAST(N'2025-03-21T23:56:18.8135181' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (88, 0, 11, 17, 0, CAST(N'2025-03-21T23:56:18.8135182' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (89, 1, 12, 2, 0, CAST(N'2025-03-21T23:57:31.8718000' AS DateTime2), CAST(N'2025-03-21T23:57:38.5585211' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (90, 1, 12, 3, 0, CAST(N'2025-03-21T23:57:31.8718071' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982092' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (91, 0, 12, 4, 0, CAST(N'2025-03-21T23:57:31.8718073' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (92, 0, 12, 6, 0, CAST(N'2025-03-21T23:57:31.8718075' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (93, 0, 12, 7, 0, CAST(N'2025-03-21T23:57:31.8718077' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (94, 0, 12, 8, 0, CAST(N'2025-03-21T23:57:31.8718079' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (95, 0, 12, 9, 0, CAST(N'2025-03-21T23:57:31.8718084' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (96, 0, 12, 10, 0, CAST(N'2025-03-21T23:57:31.8718086' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (97, 1, 12, 11, 0, CAST(N'2025-03-21T23:57:31.8718088' AS DateTime2), CAST(N'2025-03-25T01:05:39.0180652' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (98, 0, 12, 13, 0, CAST(N'2025-03-21T23:57:31.8718093' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (99, 0, 12, 14, 0, CAST(N'2025-03-21T23:57:31.8718097' AS DateTime2), NULL, NULL, 1, NULL, NULL)
GO
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (100, 0, 12, 15, 0, CAST(N'2025-03-21T23:57:31.8718102' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (101, 0, 12, 16, 0, CAST(N'2025-03-21T23:57:31.8718125' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (102, 0, 12, 17, 0, CAST(N'2025-03-21T23:57:31.8718127' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (103, 1, 13, 2, 0, CAST(N'2025-03-21T23:57:51.3360326' AS DateTime2), CAST(N'2025-03-21T23:57:53.0796441' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (104, 1, 13, 3, 0, CAST(N'2025-03-21T23:57:51.3360415' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982095' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (105, 0, 13, 4, 0, CAST(N'2025-03-21T23:57:51.3360418' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (106, 0, 13, 6, 0, CAST(N'2025-03-21T23:57:51.3360421' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (107, 0, 13, 7, 0, CAST(N'2025-03-21T23:57:51.3360424' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (108, 0, 13, 8, 0, CAST(N'2025-03-21T23:57:51.3360427' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (109, 0, 13, 9, 0, CAST(N'2025-03-21T23:57:51.3360430' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (110, 0, 13, 10, 0, CAST(N'2025-03-21T23:57:51.3360433' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (111, 1, 13, 11, 0, CAST(N'2025-03-21T23:57:51.3360435' AS DateTime2), CAST(N'2025-03-25T01:05:39.0180661' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (112, 0, 13, 13, 0, CAST(N'2025-03-21T23:57:51.3360438' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (113, 0, 13, 14, 0, CAST(N'2025-03-21T23:57:51.3360440' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (114, 0, 13, 15, 0, CAST(N'2025-03-21T23:57:51.3360443' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (115, 0, 13, 16, 0, CAST(N'2025-03-21T23:57:51.3360445' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (116, 0, 13, 17, 0, CAST(N'2025-03-21T23:57:51.3360448' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (117, 1, 14, 2, 0, CAST(N'2025-03-22T00:24:19.0989184' AS DateTime2), CAST(N'2025-03-22T00:24:21.4046495' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (118, 1, 14, 3, 0, CAST(N'2025-03-22T00:24:19.1005599' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982098' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (119, 0, 14, 4, 0, CAST(N'2025-03-22T00:24:19.1005623' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (120, 1, 15, 2, 0, CAST(N'2025-03-22T00:24:36.1095608' AS DateTime2), CAST(N'2025-03-22T00:24:37.1801558' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (121, 1, 15, 3, 0, CAST(N'2025-03-22T00:24:36.1095722' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982101' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (122, 0, 15, 4, 0, CAST(N'2025-03-22T00:24:36.1095726' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (123, 0, 15, 6, 0, CAST(N'2025-03-22T00:24:36.1095728' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (124, 0, 15, 7, 0, CAST(N'2025-03-22T00:24:36.1095731' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (125, 0, 15, 8, 0, CAST(N'2025-03-22T00:24:36.1095734' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (126, 0, 15, 9, 0, CAST(N'2025-03-22T00:24:36.1095737' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (127, 0, 15, 10, 0, CAST(N'2025-03-22T00:24:36.1095746' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (128, 1, 15, 11, 0, CAST(N'2025-03-22T00:24:36.1095749' AS DateTime2), CAST(N'2025-03-25T01:05:39.0180666' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (129, 0, 15, 13, 0, CAST(N'2025-03-22T00:24:36.1095752' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (130, 0, 15, 14, 0, CAST(N'2025-03-22T00:24:36.1095754' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (131, 0, 15, 15, 0, CAST(N'2025-03-22T00:24:36.1095757' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (132, 0, 15, 16, 0, CAST(N'2025-03-22T00:24:36.1095760' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (133, 0, 15, 17, 0, CAST(N'2025-03-22T00:24:36.1095763' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (134, 1, 16, 2, 0, CAST(N'2025-03-22T00:24:44.4526072' AS DateTime2), CAST(N'2025-03-22T00:24:48.7529421' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (135, 1, 16, 3, 0, CAST(N'2025-03-22T00:24:44.4526151' AS DateTime2), CAST(N'2025-03-22T00:25:50.5982104' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (136, 0, 16, 4, 0, CAST(N'2025-03-22T00:24:44.4526154' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (137, 1, 17, 2, 0, CAST(N'2025-03-22T00:26:10.3102528' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186102' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (138, 1, 17, 3, 0, CAST(N'2025-03-22T00:26:10.3102599' AS DateTime2), CAST(N'2025-03-22T00:26:15.5962638' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (139, 0, 17, 4, 0, CAST(N'2025-03-22T00:26:10.3102603' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (140, 1, 18, 2, 0, CAST(N'2025-03-22T00:26:34.6817457' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186130' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (141, 1, 18, 3, 0, CAST(N'2025-03-22T00:26:34.6817523' AS DateTime2), CAST(N'2025-03-22T00:26:36.6237514' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (142, 0, 18, 4, 0, CAST(N'2025-03-22T00:26:34.6817526' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (143, 0, 18, 6, 0, CAST(N'2025-03-22T00:26:34.6817528' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (144, 0, 18, 7, 0, CAST(N'2025-03-22T00:26:34.6817529' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (145, 0, 18, 8, 0, CAST(N'2025-03-22T00:26:34.6817531' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (146, 0, 18, 9, 0, CAST(N'2025-03-22T00:26:34.6817533' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (147, 0, 18, 10, 0, CAST(N'2025-03-22T00:26:34.6817534' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (148, 1, 18, 11, 0, CAST(N'2025-03-22T00:26:34.6817536' AS DateTime2), CAST(N'2025-03-25T01:05:39.0180672' AS DateTime2), NULL, 1, 11, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (149, 0, 18, 13, 0, CAST(N'2025-03-22T00:26:34.6817538' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (150, 0, 18, 14, 0, CAST(N'2025-03-22T00:26:34.6817539' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (151, 0, 18, 15, 0, CAST(N'2025-03-22T00:26:34.6817541' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (152, 0, 18, 16, 0, CAST(N'2025-03-22T00:26:34.6817543' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (153, 0, 18, 17, 0, CAST(N'2025-03-22T00:26:34.6817545' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (154, 1, 19, 2, 0, CAST(N'2025-03-22T00:26:46.1568324' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186132' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (155, 1, 19, 3, 0, CAST(N'2025-03-22T00:26:46.1568393' AS DateTime2), CAST(N'2025-03-22T00:26:48.6589386' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (156, 0, 19, 4, 0, CAST(N'2025-03-22T00:26:46.1568396' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (157, 1, 20, 2, 0, CAST(N'2025-03-22T00:26:56.4282127' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186134' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (158, 1, 20, 3, 0, CAST(N'2025-03-22T00:26:56.4282250' AS DateTime2), CAST(N'2025-03-22T00:29:50.8259957' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (159, 0, 20, 4, 0, CAST(N'2025-03-22T00:26:56.4282265' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (160, 1, 21, 2, 0, CAST(N'2025-03-22T00:27:45.6497704' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186136' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (161, 1, 21, 3, 0, CAST(N'2025-03-22T00:27:45.6497776' AS DateTime2), CAST(N'2025-03-22T00:29:50.8259979' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (162, 0, 21, 4, 0, CAST(N'2025-03-22T00:27:45.6497779' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (163, 1, 22, 2, 0, CAST(N'2025-03-22T00:28:14.6373411' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186139' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (164, 1, 22, 3, 0, CAST(N'2025-03-22T00:28:14.6373477' AS DateTime2), CAST(N'2025-03-22T00:29:50.8259981' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (165, 0, 22, 4, 0, CAST(N'2025-03-22T00:28:14.6373481' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (166, 1, 23, 2, 0, CAST(N'2025-03-22T00:28:21.3918090' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186146' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (167, 1, 23, 3, 0, CAST(N'2025-03-22T00:28:21.3918148' AS DateTime2), CAST(N'2025-03-22T00:29:50.8259983' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (168, 0, 23, 4, 0, CAST(N'2025-03-22T00:28:21.3918151' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (169, 1, 24, 2, 0, CAST(N'2025-03-22T00:36:08.9651320' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186149' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (170, 1, 24, 3, 0, CAST(N'2025-03-22T00:36:08.9662602' AS DateTime2), CAST(N'2025-03-22T00:36:33.8075485' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (171, 0, 24, 4, 0, CAST(N'2025-03-22T00:36:08.9662610' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (172, 1, 25, 2, 0, CAST(N'2025-03-22T00:36:49.2656759' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186151' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (173, 1, 25, 3, 0, CAST(N'2025-03-22T00:36:49.2667668' AS DateTime2), CAST(N'2025-03-22T00:36:50.9197009' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (174, 0, 25, 4, 0, CAST(N'2025-03-22T00:36:49.2667678' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (175, 1, 26, 2, 0, CAST(N'2025-03-22T00:37:20.4891934' AS DateTime2), CAST(N'2025-03-22T00:37:32.2186153' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (176, 1, 26, 3, 0, CAST(N'2025-03-22T00:37:20.4892020' AS DateTime2), CAST(N'2025-03-22T00:37:28.0781097' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (177, 0, 26, 4, 0, CAST(N'2025-03-22T00:37:20.4892024' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (178, 1, 27, 2, 0, CAST(N'2025-03-22T00:47:00.6490815' AS DateTime2), CAST(N'2025-03-29T08:41:17.2718075' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (179, 1, 27, 3, 0, CAST(N'2025-03-22T00:47:00.6502003' AS DateTime2), CAST(N'2025-03-22T00:47:01.7116267' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (180, 0, 27, 4, 0, CAST(N'2025-03-22T00:47:00.6502012' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (181, 1, 28, 2, 0, CAST(N'2025-03-22T00:48:31.0712244' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730671' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (182, 1, 28, 3, 0, CAST(N'2025-03-22T00:48:31.0722803' AS DateTime2), CAST(N'2025-03-22T00:48:32.9328336' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (183, 0, 28, 4, 0, CAST(N'2025-03-22T00:48:31.0722811' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (184, 1, 29, 2, 0, CAST(N'2025-03-22T00:51:02.8998774' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730684' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (185, 1, 29, 3, 0, CAST(N'2025-03-22T00:51:02.9009422' AS DateTime2), CAST(N'2025-03-22T00:51:07.5530721' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (186, 0, 29, 4, 0, CAST(N'2025-03-22T00:51:02.9009434' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (187, 1, 30, 2, 0, CAST(N'2025-03-22T00:51:17.1229227' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730686' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (188, 1, 30, 3, 0, CAST(N'2025-03-22T00:51:17.1229334' AS DateTime2), CAST(N'2025-03-22T00:51:19.1306602' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (189, 0, 30, 4, 0, CAST(N'2025-03-22T00:51:17.1229339' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (190, 1, 31, 2, 0, CAST(N'2025-03-22T00:54:11.6789725' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730689' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (191, 1, 31, 3, 0, CAST(N'2025-03-22T00:54:11.6802313' AS DateTime2), CAST(N'2025-03-22T00:54:57.0939898' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (192, 0, 31, 4, 0, CAST(N'2025-03-22T00:54:11.6802331' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (193, 1, 32, 2, 0, CAST(N'2025-03-22T00:54:20.6083263' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730693' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (194, 1, 32, 3, 0, CAST(N'2025-03-22T00:54:20.6083344' AS DateTime2), CAST(N'2025-03-22T00:54:57.0952650' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (195, 0, 32, 4, 0, CAST(N'2025-03-22T00:54:20.6083347' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (196, 1, 33, 2, 0, CAST(N'2025-03-22T00:54:52.6079152' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730695' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (197, 1, 33, 3, 0, CAST(N'2025-03-22T00:54:52.6079233' AS DateTime2), CAST(N'2025-03-22T00:54:57.0952663' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (198, 0, 33, 4, 0, CAST(N'2025-03-22T00:54:52.6079237' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (199, 1, 34, 2, 0, CAST(N'2025-03-22T00:55:21.2161552' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730698' AS DateTime2), NULL, 1, 2, NULL)
GO
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (200, 1, 34, 3, 0, CAST(N'2025-03-22T00:55:21.2161657' AS DateTime2), CAST(N'2025-03-22T00:55:40.2536194' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (201, 0, 34, 4, 0, CAST(N'2025-03-22T00:55:21.2161661' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (202, 1, 35, 2, 0, CAST(N'2025-03-22T00:55:25.4038412' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730702' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (203, 1, 35, 3, 0, CAST(N'2025-03-22T00:55:25.4038516' AS DateTime2), CAST(N'2025-03-22T00:55:40.2536240' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (204, 0, 35, 4, 0, CAST(N'2025-03-22T00:55:25.4038518' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (205, 1, 36, 2, 0, CAST(N'2025-03-22T00:55:29.1156696' AS DateTime2), CAST(N'2025-03-29T08:41:17.2730705' AS DateTime2), NULL, 1, 2, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (206, 1, 36, 3, 0, CAST(N'2025-03-22T00:55:29.1156824' AS DateTime2), CAST(N'2025-03-22T00:55:40.2536262' AS DateTime2), NULL, 1, 3, NULL)
INSERT [dbo].[NotificationRecipients] ([Id], [IsRead], [NotificationId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (207, 0, 36, 4, 0, CAST(N'2025-03-22T00:55:29.1156829' AS DateTime2), NULL, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[NotificationRecipients] OFF
GO
SET IDENTITY_INSERT [dbo].[Notifications] ON 

INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (1, N'abc', N'abc', NULL, 1, 0, CAST(N'2025-03-21T10:51:00.0285071' AS DateTime2), NULL, NULL, 1, NULL, NULL, 1)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (2, N'abcd', N'abcd', NULL, 1, 0, CAST(N'2025-03-21T23:18:35.1733680' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (3, N'hop khan cap', N'toan bo nhan vien xuong tang 1 gap toi', 2, 1, 0, CAST(N'2025-03-21T23:28:23.0026877' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (4, N'hop khan cap', N'toan bo nhan vien xuong tang 1 gap toi', 2, 1, 0, CAST(N'2025-03-21T23:31:13.7052405' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (5, N'hop khan cap', N'abc', 2, 1, 0, CAST(N'2025-03-21T23:32:20.0900233' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (6, N'pla', N'pa', 2, 1, 0, CAST(N'2025-03-21T23:41:20.2293887' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (7, N'nv', N'nbv', 2, 1, 0, CAST(N'2025-03-21T23:51:50.6705265' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (8, N'vcc', N'vcc', NULL, 1, 0, CAST(N'2025-03-21T23:52:26.6487867' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (9, N'def', N'def', NULL, 1, 0, CAST(N'2025-03-21T23:52:49.6442001' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (10, N'tui muon gap tat ca cac em', N'alal', 2, 1, 0, CAST(N'2025-03-21T23:55:45.9708545' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (11, N'tat ca cac nhan vien sale gap toi', N'gap toi mau', NULL, 1, 0, CAST(N'2025-03-21T23:56:18.7959487' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (12, N'thong bao', N'abc', NULL, 1, 0, CAST(N'2025-03-21T23:57:31.8569195' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (13, N'thong bao  2', N'adc', NULL, 1, 0, CAST(N'2025-03-21T23:57:51.3272182' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (14, N'check', N'check', 2, 1, 0, CAST(N'2025-03-22T00:24:18.9239844' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (15, N'check2', N'check2', NULL, 1, 0, CAST(N'2025-03-22T00:24:36.0919202' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (16, N'check ', N'check', 2, 1, 0, CAST(N'2025-03-22T00:24:44.4429576' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (17, N'saless', N'slawws', 2, 1, 0, CAST(N'2025-03-22T00:26:10.3010763' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (18, N'salessss', N'ágasdb', NULL, 1, 0, CAST(N'2025-03-22T00:26:34.6762304' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (19, N'sa;esdfas', N'ádfsadfsadgas', 2, 1, 0, CAST(N'2025-03-22T00:26:46.1439626' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (20, N'nvc', N'bva', 2, 1, 0, CAST(N'2025-03-22T00:26:56.4199945' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (21, N'ply', N'xsw', 2, 1, 0, CAST(N'2025-03-22T00:27:45.6416981' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (22, N'pyt', N'ssfw', 2, 1, 0, CAST(N'2025-03-22T00:28:14.6303932' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (23, N'xwd', N' aqwqwww', 2, 1, 0, CAST(N'2025-03-22T00:28:21.3887155' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (24, N'pluasw', N'ádgasvasd', 2, 1, 0, CAST(N'2025-03-22T00:36:08.7862177' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (25, N'rat chi la he cot', N'abs', 2, 1, 0, CAST(N'2025-03-22T00:36:49.1717296' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (26, N'palw', N'ábbsc', 2, 1, 0, CAST(N'2025-03-22T00:37:20.4842703' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (27, N'ali', N'alu', 2, 1, 0, CAST(N'2025-03-22T00:47:00.5055807' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (28, N'pyws', N'sadvx', 2, 1, 0, CAST(N'2025-03-22T00:48:30.9211064' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (29, N'pytw', N'sadx', 2, 1, 0, CAST(N'2025-03-22T00:51:02.7240399' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (30, N'pity', N'xxsxx', 2, 1, 0, CAST(N'2025-03-22T00:51:17.1112192' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (31, N'newnewnew', N'newenwenw', 2, 1, 0, CAST(N'2025-03-22T00:54:11.5169101' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (32, N'nounounou', N'sadfasdfasd', 2, 1, 0, CAST(N'2025-03-22T00:54:20.5948108' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (33, N'tunglapwixna', N'sdfawfdsadf', 2, 1, 0, CAST(N'2025-03-22T00:54:52.5949518' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (34, N'111', N'tungtung', 2, 1, 0, CAST(N'2025-03-22T00:55:21.1973508' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (35, N'222', N'xxxx', 2, 1, 0, CAST(N'2025-03-22T00:55:25.3912250' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
INSERT [dbo].[Notifications] ([Id], [Title], [Message], [DepartmentId], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [UserId1]) VALUES (36, N'333', N'xawx', 2, 1, 0, CAST(N'2025-03-22T00:55:29.1054000' AS DateTime2), NULL, NULL, 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Notifications] OFF
GO
SET IDENTITY_INSERT [dbo].[Salaries] ON 

INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (1, CAST(500.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(N'2023-12-12T00:00:00.0000000' AS DateTime2), 13, 0, CAST(N'2025-03-03T17:15:56.2313883' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, CAST(800.00 AS Decimal(18, 2)), CAST(50.50 AS Decimal(18, 2)), CAST(N'2020-04-25T00:00:00.0000000' AS DateTime2), 2, 0, CAST(N'2025-03-03T17:21:59.9727674' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(N'2025-03-08T00:00:00.0000000' AS DateTime2), 4, 1, CAST(N'2025-03-06T01:46:01.2342391' AS DateTime2), CAST(N'2025-03-06T02:51:55.6318764' AS DateTime2), CAST(N'2025-03-06T02:51:55.5936152' AS DateTime2), 1, 1, 1)
INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, CAST(80.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), CAST(N'2025-02-25T00:00:00.0000000' AS DateTime2), 4, 0, CAST(N'2025-03-06T01:46:29.7785959' AS DateTime2), CAST(N'2025-03-06T02:43:32.6482714' AS DateTime2), NULL, 1, 1, NULL)
INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (5, CAST(2000.00 AS Decimal(18, 2)), CAST(56.00 AS Decimal(18, 2)), CAST(N'2021-03-06T00:00:00.0000000' AS DateTime2), 6, 1, CAST(N'2025-03-06T02:52:20.7003178' AS DateTime2), CAST(N'2025-03-06T02:52:41.2127202' AS DateTime2), CAST(N'2025-03-06T02:52:41.2125439' AS DateTime2), 1, 1, 1)
INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)), CAST(N'2025-02-06T00:00:00.0000000' AS DateTime2), 14, 1, CAST(N'2025-03-06T02:54:09.3043085' AS DateTime2), CAST(N'2025-03-06T02:54:29.7522445' AS DateTime2), CAST(N'2025-03-06T02:54:29.7515185' AS DateTime2), 1, 1, 1)
INSERT [dbo].[Salaries] ([Id], [Basic], [Allowance], [EffectiveAt], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (7, CAST(200.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), CAST(N'2025-03-14T00:00:00.0000000' AS DateTime2), 17, 0, CAST(N'2025-03-15T01:58:21.8570657' AS DateTime2), NULL, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Salaries] OFF
GO
SET IDENTITY_INSERT [dbo].[SalaryPayments] ON 

INSERT [dbo].[SalaryPayments] ([Id], [TotalSalary], [TotalBonus], [TotalPaid], [PaidAt], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [TotalPenalty]) VALUES (10013, CAST(850.50 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(850.50 AS Decimal(18, 2)), CAST(N'2025-03-29T08:40:35.2176790' AS DateTime2), 1, 2, 0, CAST(N'2025-03-29T08:39:17.6336757' AS DateTime2), CAST(N'2025-03-29T08:40:35.2183221' AS DateTime2), NULL, 1, 1, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SalaryPayments] ([Id], [TotalSalary], [TotalBonus], [TotalPaid], [PaidAt], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [TotalPenalty]) VALUES (10014, CAST(90.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(90.00 AS Decimal(18, 2)), NULL, 2, 4, 0, CAST(N'2025-03-29T08:39:17.6351273' AS DateTime2), CAST(N'2025-03-29T08:40:37.1559673' AS DateTime2), NULL, 1, 1, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SalaryPayments] ([Id], [TotalSalary], [TotalBonus], [TotalPaid], [PaidAt], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [TotalPenalty]) VALUES (10015, CAST(510.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, 0, 13, 0, CAST(N'2025-03-29T08:39:17.6351292' AS DateTime2), NULL, NULL, 1, NULL, NULL, CAST(4023.00 AS Decimal(18, 2)))
INSERT [dbo].[SalaryPayments] ([Id], [TotalSalary], [TotalBonus], [TotalPaid], [PaidAt], [Status], [UserId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy], [TotalPenalty]) VALUES (10016, CAST(1000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), NULL, 0, 17, 0, CAST(N'2025-03-29T08:39:17.6351297' AS DateTime2), NULL, NULL, 1, NULL, NULL, CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[SalaryPayments] OFF
GO

/*
	user          | password |
	admin         | 111      |
	all employees | aaa      |
*/
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (1, N'admin', N'$2a$11$y1sGQxfzyq59GVdusW3.X.Oy3rQPT0LlIq7T5TcYmF6SkVs0Gew5a')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (2, N'tamhtt1', N'$2a$11$5Pv4w/es0sqYw3hIXRJKlefp2RrszHKViqjdvr7xeiOwDoL3v/s7i')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (3, N'dungnb1', N'$2a$11$2e7qmaqMzsGQcZZfqA4O/OIyPm.FJPZdCxJxNT5/0tnthCDbSf3MW')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (4, N'anhnt1', N'$2a$11$qN19NLUZs4f14mp.1DaK8uXNNLBcy1MqQUgT3sRdy9jOJYUTHDEAu')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (6, N'longtd1', N'$2a$11$KokkxDcBDLpoW588NXqu9OoyIkP771YSFT63pbpBbkOWo8w4S2kPy')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (7, N'anhnv1', N'$2a$11$qMpkuYGRgqBXgGAEGYVszed4q7n0lUYHnVGwjafQHXjslJPKNHjqm')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (8, N'vietna1', N'$2a$11$DRNZpT0x.W6j5SPFMiRIQuMwm0UnmP.alyScEOD0UpmJ1P6GaY9cq')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (9, N'minhdq1', N'$2a$11$VWQeI.hioVCeox46gmg8/eumzKjCck3rryT/B3IabUXjcsbJV6MdC')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (10, N'tungds1', N'$2a$11$t1euhnkO4XdLmgwC7orqYOsRz8Ivfn1blriUA2Gjv5JkvZUMEH6jy')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (11, N'duccm1', N'$2a$11$cA4nhK13S2QGIKCbZkzQz.2yGB5D10pQA6G0uxKCKYEazR/6hPUne')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (12, N'tungh1', N'$2a$11$AihPydaju4CeRy/UwDoaq.vcjILPIGIr17/hFjzNGofsiu5rplzty')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (13, N'thuandv1', N'$2a$11$anND0SqhhLmKKJU4DUSDpeplIZIRZKySIoo2Qd/mLNBf3/V1P7OAi')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (14, N'linhtt1', N'$2a$11$zbhxmoW2MizH1nqJGYc1I.q.CRn4Rj5J8hAJQQsS5xKsa2XSKqMdi')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (15, N'anhtn1', N'$2a$11$TxJ2kqHaquEAn6W2SWLbpuwA8W2TxakhkyLaEWWM07xAvT1i.jE/K')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (16, N'honghp1', N'$2a$11$I5u.pEBXjKxJTlPkNtguie8F5nic8mqQ7I3L.TXbIwLPUpMsyBJcm')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (17, N'phuclq1', N'$2a$11$P2q3E2NxDM8X/fVonTvNvOUx9CPygmOBzsk042hYDmvcoUralbxNe')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (10017, N'cuongtv1', N'$2a$11$uXW0uTgj0RX/JA25nnHeIu5Toob49ow1RtEPBbnAiZEOLj4sIq9y6')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (10018, N'NamDD1', N'$2a$11$RO9yr7dLngWr7PtnXeAWwOVIMn5McMU7UuAK8I9TN3amZMOnjosyy')
INSERT [dbo].[UserAuths] ([UserId], [Username], [PasswordHash]) VALUES (10019, N'TrungHD1', N'$2a$11$NzstzDBY3NR/81BWyQ4WXOPtI/LRXgHSS/DRHzr8L.BytRTb22LMi')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (1, 1, N'FullNameAdmin', CAST(N'1999-01-01' AS Date), 1, N'AddressAdmin', N'0123456789', 0, CAST(N'1999-01-01' AS Date), NULL, 2, 0, NULL, CAST(N'2025-03-28T22:48:51.1565290' AS DateTime2), NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (2, 2, N'Hoang Thi Thanh Tam', CAST(N'2003-12-20' AS Date), 2, N'So nha', N'0865821503', 3, CAST(N'2018-02-05' AS Date), NULL, 2, 0, NULL, CAST(N'2025-03-28T22:48:37.9634320' AS DateTime2), NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (3, 2, N'Ngo Ba Dung', CAST(N'2003-11-20' AS Date), 1, N'So nha dung', N'0865851502', 0, CAST(N'2025-01-12' AS Date), NULL, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (4, 2, N'Ngo Tuan Anh', CAST(N'1999-01-26' AS Date), 1, N'So nha tuan anh', N'0865851501', 3, CAST(N'2025-01-06' AS Date), NULL, 2, 0, NULL, CAST(N'2025-03-02T00:36:29.9353478' AS DateTime2), NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (6, 2, N'Tran Duc Long', CAST(N'2002-01-27' AS Date), 1, N'So nha Long', N'0865851512', 3, CAST(N'2025-01-19' AS Date), NULL, 6, 0, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (7, 2, N'Nguyen Viet Anh', CAST(N'1994-11-01' AS Date), 1, N'So nha Long', N'0865851512', 3, CAST(N'2022-12-12' AS Date), NULL, 4, 0, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (8, 2, N'Nguyen Anh Viet', CAST(N'1999-01-17' AS Date), 1, N'So 1', N'0999999999', 2, CAST(N'2019-01-06' AS Date), NULL, 5, 0, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (9, 2, N'Do Quang Minh', CAST(N'2003-01-08' AS Date), 1, N'So nha quang minh', N'0865851593', 3, CAST(N'2014-05-05' AS Date), NULL, 4, 0, NULL, CAST(N'2025-03-24T09:19:39.2042703' AS DateTime2), NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (10, 2, N'Dinh Son Tung', CAST(N'2003-03-15' AS Date), 1, N'So 757', N'0978197214', 2, CAST(N'2021-12-30' AS Date), NULL, 5, 0, CAST(N'2025-03-01T14:44:46.8164840' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (11, 2, N'Cao Minh Duc', CAST(N'2003-02-27' AS Date), 1, N'So 123456', N'0985651212', 3, CAST(N'2019-12-21' AS Date), NULL, 4, 0, NULL, CAST(N'2025-03-01T23:58:57.0029117' AS DateTime2), NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (12, 2, N'Hoang Tung', CAST(N'1994-12-02' AS Date), 1, N'so 1999', N'0989565453', 3, CAST(N'2025-02-23' AS Date), NULL, 4, 1, CAST(N'2025-03-01T14:52:36.4290642' AS DateTime2), CAST(N'2025-03-02T01:14:54.2312637' AS DateTime2), CAST(N'2025-03-02T01:14:54.1849137' AS DateTime2), 1, 1, 1)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (13, 2, N'Do Van Thuan', CAST(N'1997-12-14' AS Date), 1, N'so long an', N'0543123456', 2, CAST(N'2023-02-12' AS Date), N'https://prn222ems.blob.core.windows.net/ems-avatar/image/jpeg', 5, 0, CAST(N'2025-03-01T15:00:58.7771234' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (14, 2, N'Tran Thai Linh', CAST(N'2000-02-02' AS Date), 1, N'de la thanh', N'0978889191', 2, CAST(N'2022-02-22' AS Date), NULL, 6, 0, NULL, CAST(N'2025-03-02T01:13:37.6289065' AS DateTime2), CAST(N'2025-03-02T01:13:37.5819015' AS DateTime2), NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (15, 2, N'Tran Ngoc Anh', CAST(N'2002-03-04' AS Date), 2, N'so nha ngoc anh', N'0789891982', 3, CAST(N'2025-01-05' AS Date), NULL, 3, 0, NULL, CAST(N'2025-03-01T23:46:19.8033145' AS DateTime2), NULL, NULL, 1, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (16, 2, N'Hoang Phi Hong', CAST(N'2000-02-10' AS Date), 1, N'TQ', N'0987654345', 3, CAST(N'2025-02-18' AS Date), NULL, 7, 0, CAST(N'2025-03-06T01:19:32.5511327' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (17, 2, N'Ly Quang Phuc', CAST(N'2003-12-24' AS Date), 1, N'Phu Tho', N'0976527123', 2, CAST(N'2025-03-09' AS Date), NULL, 3, 0, CAST(N'2025-03-10T11:15:22.5554763' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (10017, 2, N'Tran Van Cuong', CAST(N'2003-05-13' AS Date), 1, N'NA', N'0756718923', 2, CAST(N'2025-01-23' AS Date), NULL, 5, 0, CAST(N'2025-03-24T09:15:00.3223871' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (10018, 2, N'Do Duy Nam', CAST(N'1999-03-04' AS Date), 1, N'HN', N'0865235133', 3, CAST(N'2025-03-03' AS Date), NULL, 2, 0, CAST(N'2025-03-24T09:17:17.5563947' AS DateTime2), NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[Users] ([Id], [Role], [Fullname], [Birth], [Gender], [Address], [Phone], [Duty], [JoinedAt], [Avatar], [DepartmentId], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy]) VALUES (10019, 2, N'Hoang Duc Trung', CAST(N'1997-03-03' AS Date), 1, N'TN', N'0987678678', 3, CAST(N'2025-03-02' AS Date), NULL, 4, 0, CAST(N'2025-03-24T09:22:49.3437799' AS DateTime2), NULL, NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  Index [IX_ActivityLogs_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_ActivityLogs_UserId] ON [dbo].[ActivityLogs]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Attendances_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Attendances_UserId] ON [dbo].[Attendances]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Bonuses_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Bonuses_UserId] ON [dbo].[Bonuses]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_LeaveBalances_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_LeaveBalances_UserId] ON [dbo].[LeaveBalances]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_LeaveRequests_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_LeaveRequests_UserId] ON [dbo].[LeaveRequests]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_NotificationRecipients_NotificationId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_NotificationRecipients_NotificationId] ON [dbo].[NotificationRecipients]
(
	[NotificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_NotificationRecipients_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_NotificationRecipients_UserId] ON [dbo].[NotificationRecipients]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_DepartmentId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_DepartmentId] ON [dbo].[Notifications]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_UserId] ON [dbo].[Notifications]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Notifications_UserId1]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_UserId1] ON [dbo].[Notifications]
(
	[UserId1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Salaries_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Salaries_UserId] ON [dbo].[Salaries]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_SalaryPayments_UserId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_SalaryPayments_UserId] ON [dbo].[SalaryPayments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Users_DepartmentId]    Script Date: 3/29/2025 9:16:17 AM ******/
CREATE NONCLUSTERED INDEX [IX_Users_DepartmentId] ON [dbo].[Users]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LeaveBalances] ADD  DEFAULT ((0)) FOR [RemainingSickDay]
GO
ALTER TABLE [dbo].[Notifications] ADD  DEFAULT (CONVERT([bigint],(0))) FOR [UserId]
GO
ALTER TABLE [dbo].[SalaryPayments] ADD  DEFAULT ((0.0)) FOR [TotalPenalty]
GO
ALTER TABLE [dbo].[ActivityLogs]  WITH CHECK ADD  CONSTRAINT [FK_ActivityLogs_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ActivityLogs] CHECK CONSTRAINT [FK_ActivityLogs_Users_UserId]
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD  CONSTRAINT [FK_Attendances_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Attendances] CHECK CONSTRAINT [FK_Attendances_Users_UserId]
GO
ALTER TABLE [dbo].[Bonuses]  WITH CHECK ADD  CONSTRAINT [FK_Bonuses_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bonuses] CHECK CONSTRAINT [FK_Bonuses_Users_UserId]
GO
ALTER TABLE [dbo].[LeaveBalances]  WITH CHECK ADD  CONSTRAINT [FK_LeaveBalances_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LeaveBalances] CHECK CONSTRAINT [FK_LeaveBalances_Users_UserId]
GO
ALTER TABLE [dbo].[LeaveRequests]  WITH CHECK ADD  CONSTRAINT [FK_LeaveRequests_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LeaveRequests] CHECK CONSTRAINT [FK_LeaveRequests_Users_UserId]
GO
ALTER TABLE [dbo].[NotificationRecipients]  WITH CHECK ADD  CONSTRAINT [FK_NotificationRecipients_Notifications_NotificationId] FOREIGN KEY([NotificationId])
REFERENCES [dbo].[Notifications] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificationRecipients] CHECK CONSTRAINT [FK_NotificationRecipients_Notifications_NotificationId]
GO
ALTER TABLE [dbo].[NotificationRecipients]  WITH CHECK ADD  CONSTRAINT [FK_NotificationRecipients_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NotificationRecipients] CHECK CONSTRAINT [FK_NotificationRecipients_Users_UserId]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Departments_DepartmentId]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users_UserId]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users_UserId1] FOREIGN KEY([UserId1])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users_UserId1]
GO
ALTER TABLE [dbo].[Salaries]  WITH CHECK ADD  CONSTRAINT [FK_Salaries_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Salaries] CHECK CONSTRAINT [FK_Salaries_Users_UserId]
GO
ALTER TABLE [dbo].[SalaryPayments]  WITH CHECK ADD  CONSTRAINT [FK_SalaryPayments_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[SalaryPayments] CHECK CONSTRAINT [FK_SalaryPayments_Users_UserId]
GO
ALTER TABLE [dbo].[UserAuths]  WITH CHECK ADD  CONSTRAINT [FK_UserAuths_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAuths] CHECK CONSTRAINT [FK_UserAuths_Users_UserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Departments_DepartmentId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Departments_DepartmentId]
GO
USE [master]
GO
ALTER DATABASE [emstest] SET  READ_WRITE 
GO
