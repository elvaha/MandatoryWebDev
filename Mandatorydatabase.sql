USE [master]
GO
/****** Object:  Database [AarhusWebDev]    Script Date: 13-10-2016 18:01:48 ******/
CREATE DATABASE [AarhusWebDev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AarhusWebDev', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\AarhusWebDev.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AarhusWebDev_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\AarhusWebDev_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AarhusWebDev] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AarhusWebDev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AarhusWebDev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AarhusWebDev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AarhusWebDev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AarhusWebDev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AarhusWebDev] SET ARITHABORT OFF 
GO
ALTER DATABASE [AarhusWebDev] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AarhusWebDev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AarhusWebDev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AarhusWebDev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AarhusWebDev] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AarhusWebDev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AarhusWebDev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AarhusWebDev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AarhusWebDev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AarhusWebDev] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AarhusWebDev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AarhusWebDev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AarhusWebDev] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AarhusWebDev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AarhusWebDev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AarhusWebDev] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AarhusWebDev] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AarhusWebDev] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AarhusWebDev] SET  MULTI_USER 
GO
ALTER DATABASE [AarhusWebDev] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AarhusWebDev] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AarhusWebDev] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AarhusWebDev] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [AarhusWebDev] SET DELAYED_DURABILITY = DISABLED 
GO
USE [AarhusWebDev]
GO
/****** Object:  Table [dbo].[cmsContent]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[contentType] [int] NOT NULL,
 CONSTRAINT [PK_cmsContent] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](255) NULL,
	[icon] [nvarchar](255) NULL,
	[thumbnail] [nvarchar](255) NOT NULL CONSTRAINT [DF_cmsContentType_thumbnail]  DEFAULT ('folder.png'),
	[description] [nvarchar](1500) NULL,
	[isContainer] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_isContainer]  DEFAULT ('0'),
	[allowAtRoot] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_allowAtRoot]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType2ContentType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType2ContentType](
	[parentContentTypeId] [int] NOT NULL,
	[childContentTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsContentType2ContentType] PRIMARY KEY CLUSTERED 
(
	[parentContentTypeId] ASC,
	[childContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentTypeAllowedContentType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentTypeAllowedContentType](
	[Id] [int] NOT NULL,
	[AllowedId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL CONSTRAINT [df_cmsContentTypeAllowedContentType_sortOrder]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AllowedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentVersion]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentVersion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContentId] [int] NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL,
	[VersionDate] [datetime] NOT NULL CONSTRAINT [DF_cmsContentVersion_VersionDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentXml]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentXml](
	[nodeId] [int] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[propertyEditorAlias] [nvarchar](255) NOT NULL,
	[dbType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_cmsDataType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataTypePreValues]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataTypePreValues](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datatypeNodeId] [int] NOT NULL,
	[value] [ntext] NULL,
	[sortorder] [int] NOT NULL,
	[alias] [nvarchar](50) NULL,
 CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDictionary]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDictionary](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[parent] [uniqueidentifier] NULL,
	[key] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsDictionary] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocument]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocument](
	[nodeId] [int] NOT NULL,
	[published] [bit] NOT NULL,
	[documentUser] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[releaseDate] [datetime] NULL,
	[expireDate] [datetime] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_cmsDocument_updateDate]  DEFAULT (getdate()),
	[templateId] [int] NULL,
	[newest] [bit] NOT NULL CONSTRAINT [DF_cmsDocument_newest]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocument] PRIMARY KEY CLUSTERED 
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocumentType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocumentType](
	[contentTypeNodeId] [int] NOT NULL,
	[templateNodeId] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_cmsDocumentType_IsDefault]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY CLUSTERED 
(
	[contentTypeNodeId] ASC,
	[templateNodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsLanguageText]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsLanguageText](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[languageId] [int] NOT NULL,
	[UniqueId] [uniqueidentifier] NOT NULL,
	[value] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacro]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[macroUseInEditor] [bit] NOT NULL CONSTRAINT [DF_cmsMacro_macroUseInEditor]  DEFAULT ('0'),
	[macroRefreshRate] [int] NOT NULL CONSTRAINT [DF_cmsMacro_macroRefreshRate]  DEFAULT ('0'),
	[macroAlias] [nvarchar](255) NOT NULL,
	[macroName] [nvarchar](255) NULL,
	[macroScriptType] [nvarchar](255) NULL,
	[macroScriptAssembly] [nvarchar](255) NULL,
	[macroXSLT] [nvarchar](255) NULL,
	[macroCacheByPage] [bit] NOT NULL CONSTRAINT [DF_cmsMacro_macroCacheByPage]  DEFAULT ('1'),
	[macroCachePersonalized] [bit] NOT NULL CONSTRAINT [DF_cmsMacro_macroCachePersonalized]  DEFAULT ('0'),
	[macroDontRender] [bit] NOT NULL CONSTRAINT [DF_cmsMacro_macroDontRender]  DEFAULT ('0'),
	[macroPython] [nvarchar](255) NULL,
 CONSTRAINT [PK_cmsMacro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacroProperty]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacroProperty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[editorAlias] [nvarchar](255) NOT NULL,
	[macro] [int] NOT NULL,
	[macroPropertySortOrder] [int] NOT NULL,
	[macroPropertyAlias] [nvarchar](50) NOT NULL,
	[macroPropertyName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsMacroProperty] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember](
	[nodeId] [int] NOT NULL,
	[Email] [nvarchar](1000) NOT NULL CONSTRAINT [DF_cmsMember_Email]  DEFAULT (''''),
	[LoginName] [nvarchar](1000) NOT NULL CONSTRAINT [DF_cmsMember_LoginName]  DEFAULT (''''),
	[Password] [nvarchar](1000) NOT NULL CONSTRAINT [DF_cmsMember_Password]  DEFAULT (''''),
 CONSTRAINT [PK_cmsMember] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember2MemberGroup]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember2MemberGroup](
	[Member] [int] NOT NULL,
	[MemberGroup] [int] NOT NULL,
 CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY CLUSTERED 
(
	[Member] ASC,
	[MemberGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMemberType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMemberType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[NodeId] [int] NOT NULL,
	[propertytypeId] [int] NOT NULL,
	[memberCanEdit] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_memberCanEdit]  DEFAULT ('0'),
	[viewOnProfile] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_viewOnProfile]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsMemberType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPreviewXml]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPreviewXml](
	[nodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyData]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contentNodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NULL,
	[propertytypeid] [int] NOT NULL,
	[dataInt] [int] NULL,
	[dataDecimal] [decimal](38, 6) NULL,
	[dataDate] [datetime] NULL,
	[dataNvarchar] [nvarchar](500) NULL,
	[dataNtext] [ntext] NULL,
 CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dataTypeId] [int] NOT NULL,
	[contentTypeId] [int] NOT NULL,
	[propertyTypeGroupId] [int] NULL,
	[Alias] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[sortOrder] [int] NOT NULL CONSTRAINT [DF_cmsPropertyType_sortOrder]  DEFAULT ('0'),
	[mandatory] [bit] NOT NULL CONSTRAINT [DF_cmsPropertyType_mandatory]  DEFAULT ('0'),
	[validationRegExp] [nvarchar](255) NULL,
	[Description] [nvarchar](2000) NULL,
	[UniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyType_UniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyTypeGroup]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyTypeGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contenttypeNodeId] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[sortorder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyTypeGroup_uniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyTypeGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTagRelationship]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTagRelationship](
	[nodeId] [int] NOT NULL,
	[tagId] [int] NOT NULL,
	[propertyTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[propertyTypeId] ASC,
	[tagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTags]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [nvarchar](200) NULL,
	[ParentId] [int] NULL,
	[group] [nvarchar](100) NULL,
 CONSTRAINT [PK_cmsTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTask]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTask](
	[closed] [bit] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskTypeId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[parentUserId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Comment] [nvarchar](500) NULL,
 CONSTRAINT [PK_cmsTask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTaskType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTaskType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsTaskType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTemplate]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTemplate](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](100) NULL,
	[design] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsTemplate] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccess]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccess](
	[id] [uniqueidentifier] NOT NULL,
	[nodeId] [int] NOT NULL,
	[loginNodeId] [int] NOT NULL,
	[noAccessNodeId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoAccess_createDate]  DEFAULT (getdate()),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoAccess_updateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_umbracoAccess] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccessRule]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccessRule](
	[id] [uniqueidentifier] NOT NULL,
	[accessId] [uniqueidentifier] NOT NULL,
	[ruleValue] [nvarchar](255) NOT NULL,
	[ruleType] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoAccessRule_createDate]  DEFAULT (getdate()),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoAccessRule_updateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_umbracoAccessRule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoCacheInstruction]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoCacheInstruction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[utcStamp] [datetime] NOT NULL,
	[jsonInstruction] [ntext] NOT NULL,
	[originated] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_umbracoCacheInstruction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoDeployChecksum]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoDeployChecksum](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[entityType] [nvarchar](32) NOT NULL,
	[entityGuid] [uniqueidentifier] NULL,
	[entityPath] [nvarchar](256) NULL,
	[localChecksum] [nvarchar](32) NOT NULL,
	[compositeChecksum] [nvarchar](32) NULL,
 CONSTRAINT [PK_umbracoDeployChecksum] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoDeployDependency]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoDeployDependency](
	[sourceId] [int] NOT NULL,
	[targetId] [int] NOT NULL,
	[mode] [int] NOT NULL,
 CONSTRAINT [PK_umbracoDeployDependency] PRIMARY KEY CLUSTERED 
(
	[sourceId] ASC,
	[targetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoDomains]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoDomains](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[domainDefaultLanguage] [int] NULL,
	[domainRootStructureID] [int] NULL,
	[domainName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoDomains] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoExternalLogin]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoExternalLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[loginProvider] [nvarchar](4000) NOT NULL,
	[providerKey] [nvarchar](4000) NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoExternalLogin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLanguage]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLanguage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[languageISOCode] [nvarchar](10) NULL,
	[languageCultureName] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLog]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[NodeId] [int] NOT NULL,
	[Datestamp] [datetime] NOT NULL CONSTRAINT [DF_umbracoLog_Datestamp]  DEFAULT (getdate()),
	[logHeader] [nvarchar](50) NOT NULL,
	[logComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_umbracoLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoMigration]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoMigration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoMigration_createDate]  DEFAULT (getdate()),
	[version] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_umbracoMigration] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoNode]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoNode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trashed] [bit] NOT NULL CONSTRAINT [DF_umbracoNode_trashed]  DEFAULT ('0'),
	[parentID] [int] NOT NULL,
	[nodeUser] [int] NULL,
	[level] [int] NOT NULL,
	[path] [nvarchar](150) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_umbracoNode_uniqueID]  DEFAULT (newid()),
	[text] [nvarchar](255) NULL,
	[nodeObjectType] [uniqueidentifier] NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoNode_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_structure] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRedirectUrl]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRedirectUrl](
	[id] [uniqueidentifier] NOT NULL,
	[contentKey] [uniqueidentifier] NOT NULL,
	[createDateUtc] [datetime] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[urlHash] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_umbracoRedirectUrl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelation]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentId] [int] NOT NULL,
	[childId] [int] NOT NULL,
	[relType] [int] NOT NULL,
	[datetime] [datetime] NOT NULL CONSTRAINT [DF_umbracoRelation_datetime]  DEFAULT (getdate()),
	[comment] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_umbracoRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelationType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelationType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dual] [bit] NOT NULL,
	[parentObjectType] [uniqueidentifier] NOT NULL,
	[childObjectType] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoServer]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoServer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[computerName] [nvarchar](255) NOT NULL,
	[registeredDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoServer_registeredDate]  DEFAULT (getdate()),
	[lastNotifiedDate] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isMaster] [bit] NOT NULL,
 CONSTRAINT [PK_umbracoServer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userDisabled] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userDisabled]  DEFAULT ('0'),
	[userNoConsole] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userNoConsole]  DEFAULT ('0'),
	[userType] [int] NOT NULL,
	[startStructureID] [int] NOT NULL,
	[startMediaID] [int] NULL,
	[userName] [nvarchar](255) NOT NULL,
	[userLogin] [nvarchar](125) NOT NULL,
	[userPassword] [nvarchar](500) NOT NULL,
	[userEmail] [nvarchar](255) NOT NULL,
	[userLanguage] [nvarchar](10) NULL,
	[securityStampToken] [nvarchar](255) NULL,
	[failedLoginAttempts] [int] NULL,
	[lastLockoutDate] [datetime] NULL,
	[lastPasswordChangeDate] [datetime] NULL,
	[lastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2app]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2app](
	[user] [int] NOT NULL,
	[app] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_user2app] PRIMARY KEY CLUSTERED 
(
	[user] ASC,
	[app] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodeNotify]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodeNotify](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[action] [nchar](1) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodePermission]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodePermission](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[permission] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodePermission] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserType]    Script Date: 13-10-2016 18:01:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userTypeAlias] [nvarchar](50) NULL,
	[userTypeName] [nvarchar](255) NOT NULL,
	[userTypeDefaultPermissions] [nvarchar](50) NULL,
 CONSTRAINT [PK_umbracoUserType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[cmsContent] ON 

INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (1, 1075, 1050)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (2, 1076, 1052)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (3, 1077, 1067)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (4, 1078, 1055)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (5, 1079, 1055)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (6, 1080, 1071)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (7, 1081, 1071)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (8, 1088, 1087)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (9, 1089, 1044)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (10, 1090, 1044)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (11, 1092, 1058)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (12, 1093, 1055)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (13, 1094, 1058)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (15, 1108, 1058)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (16, 1112, 1110)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (17, 1119, 1052)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (18, 1120, 1067)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (19, 1121, 1055)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (20, 1122, 1055)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (21, 1123, 1071)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (22, 1124, 1071)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (23, 1127, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (24, 1130, 1126)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (25, 1131, 1118)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (26, 1133, 1126)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (27, 1134, 1118)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (28, 1135, 1071)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (29, 1141, 1139)
SET IDENTITY_INSERT [dbo].[cmsContent] OFF
SET IDENTITY_INSERT [dbo].[cmsContentType] ON 

INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (531, 1044, N'Member', N'icon-user', N'icon-user', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (532, 1031, N'Folder', N'icon-folder', N'icon-folder', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (533, 1032, N'Image', N'icon-picture', N'icon-picture', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (534, 1033, N'File', N'icon-document', N'icon-document', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (535, 1048, N'master', N'icon-document', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (536, 1050, N'homePage', N'icon-home', N'folder.png', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (537, 1052, N'articleMain', N'icon-categories color-green', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (538, 1055, N'articleItem', N'icon-article color-blue', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (539, 1058, N'textPage', N'icon-umb-content', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (540, 1067, N'projectMain', N'icon-file-cabinet color-orange', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (541, 1071, N'projectsItem', N'icon-box-alt color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (542, 1087, N'prospect', N'icon-user', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (544, 1110, N'aboutPage', N'icon-document', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (545, 1118, N'boardMessage', N'icon-document', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (546, 1126, N'boardMessages', N'icon-info color-green', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (547, 1138, N'contactForm', N'icon-document', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (548, 1139, N'memberView', N'icon-users-alt color-orange', N'folder.png', NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[cmsContentType] OFF
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1050)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1052)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1055)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1058)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1067)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1071)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1110)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1126)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1048, 1139)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1031, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1032, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1033, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1050, 1052, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1050, 1058, 1)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1050, 1067, 2)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1050, 1110, 3)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1050, 1126, 4)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1050, 1139, 5)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1052, 1055, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1067, 1071, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1126, 1118, 0)
SET IDENTITY_INSERT [dbo].[cmsContentVersion] ON 

INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', CAST(N'2016-09-20 09:40:49.340' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (2, 1076, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', CAST(N'2016-09-20 09:42:22.107' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (3, 1077, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', CAST(N'2016-09-20 09:43:24.850' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (4, 1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', CAST(N'2016-09-20 09:46:50.900' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (5, 1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', CAST(N'2016-09-20 09:47:51.207' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (6, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', CAST(N'2016-09-20 09:49:40.150' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (7, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', CAST(N'2016-09-20 09:50:31.570' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (8, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', CAST(N'2016-10-13 17:40:05.163' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (9, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', CAST(N'2016-10-13 17:46:20.410' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (10, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', CAST(N'2016-10-13 17:42:35.853' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (11, 1092, N'62209e30-c43f-4767-818d-5c6d553d25fa', CAST(N'2016-09-26 09:47:42.117' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (12, 1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', CAST(N'2016-09-26 09:49:06.313' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (13, 1094, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', CAST(N'2016-09-26 10:22:03.007' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (14, 1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', CAST(N'2016-09-26 10:56:39.127' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (16, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', CAST(N'2016-10-10 10:11:15.233' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (17, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', CAST(N'2016-10-10 10:49:35.920' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (18, 1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', CAST(N'2016-10-10 11:21:46.997' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (20, 1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', CAST(N'2016-10-10 11:28:27.763' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (21, 1112, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', CAST(N'2016-10-10 11:30:01.787' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (22, 1076, N'd61239b7-9426-4b8d-b880-364f822f0974', CAST(N'2016-10-11 20:12:48.887' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (23, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', CAST(N'2016-10-11 20:12:49.223' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (24, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', CAST(N'2016-10-11 20:12:49.253' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (25, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', CAST(N'2016-10-11 20:12:49.290' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (26, 1076, N'e7929ac3-bebc-4801-8788-d249c4fdf418', CAST(N'2016-10-11 20:12:49.313' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (27, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', CAST(N'2016-10-11 20:12:49.323' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (28, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', CAST(N'2016-10-11 20:12:49.327' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (29, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', CAST(N'2016-10-11 20:12:49.330' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (30, 1077, N'ff5c19c1-988a-4462-97cb-36949b2aa670', CAST(N'2016-10-11 20:12:54.307' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (31, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', CAST(N'2016-10-11 20:12:54.333' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (32, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', CAST(N'2016-10-11 20:12:54.357' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (33, 1077, N'0168e231-864a-4863-862c-cf8541ff5a61', CAST(N'2016-10-11 20:12:54.373' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (34, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', CAST(N'2016-10-11 20:12:54.380' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (35, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', CAST(N'2016-10-11 20:12:54.387' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (36, 1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', CAST(N'2016-10-11 20:14:05.620' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (37, 1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', CAST(N'2016-10-11 20:15:05.613' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (38, 1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', CAST(N'2016-10-11 20:15:47.047' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (39, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', CAST(N'2016-10-11 20:16:21.560' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (40, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', CAST(N'2016-10-11 20:16:51.987' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (41, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', CAST(N'2016-10-11 20:17:32.320' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (42, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', CAST(N'2016-10-11 20:17:45.343' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (43, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', CAST(N'2016-10-11 20:18:26.347' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (44, 1092, N'8d38e053-a525-4e65-b76d-6e1687109392', CAST(N'2016-10-11 21:48:30.220' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (45, 1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', CAST(N'2016-10-11 21:48:37.653' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (46, 1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', CAST(N'2016-10-11 21:48:44.363' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (47, 1112, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', CAST(N'2016-10-11 21:48:49.367' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (48, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', CAST(N'2016-10-11 21:48:57.630' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (49, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', CAST(N'2016-10-11 21:49:03.553' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (50, 1119, N'10351876-5e24-473a-940c-afe9f0b7af17', CAST(N'2016-10-11 21:49:09.020' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (51, 1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', CAST(N'2016-10-11 21:49:21.613' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (52, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', CAST(N'2016-10-12 03:30:55.630' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (53, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', CAST(N'2016-10-11 21:49:35.923' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (54, 1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', CAST(N'2016-10-12 03:26:11.913' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (55, 1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', CAST(N'2016-10-12 04:00:31.360' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (56, 1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', CAST(N'2016-10-12 04:01:03.100' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (57, 1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', CAST(N'2016-10-12 04:01:34.930' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (58, 1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', CAST(N'2016-10-12 04:10:55.370' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (59, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', CAST(N'2016-10-12 12:05:55.450' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (60, 1127, N'443c67e8-1954-4583-858b-8cf7ffd0e612', CAST(N'2016-10-12 12:05:45.770' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (61, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', CAST(N'2016-10-12 12:10:27.473' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (62, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', CAST(N'2016-10-12 12:10:52.943' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (63, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', CAST(N'2016-10-12 12:14:48.383' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (64, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', CAST(N'2016-10-12 12:23:02.477' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (65, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', CAST(N'2016-10-12 12:23:49.723' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (66, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', CAST(N'2016-10-12 12:26:32.683' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (67, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', CAST(N'2016-10-12 12:31:02.387' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (68, 1112, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', CAST(N'2016-10-12 14:22:21.713' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (69, 1112, N'5195df88-ac00-4072-979f-2ef3464d1b71', CAST(N'2016-10-12 14:22:26.080' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (70, 1112, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', CAST(N'2016-10-12 14:28:02.067' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (71, 1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', CAST(N'2016-10-12 14:39:12.277' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (72, 1130, N'aad9bf99-da5c-45c2-834d-6163a51d007b', CAST(N'2016-10-12 16:40:13.070' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (73, 1131, N'cbe2c390-9d41-425f-819e-58bab291c22e', CAST(N'2016-10-12 16:41:31.987' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (74, 1130, N'e1fd8011-22c5-47ab-ad89-5e19ca24b410', CAST(N'2016-10-13 13:12:38.697' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (75, 1131, N'b6170db1-3fe7-46a2-808b-49286e309ec0', CAST(N'2016-10-13 13:12:39.113' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (76, 1130, N'e7c8c962-e52e-401f-a621-7457aef2f1be', CAST(N'2016-10-13 13:12:39.183' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (77, 1131, N'd3cb6479-f887-410b-ba90-6b59c7a3a8b5', CAST(N'2016-10-13 13:12:39.210' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (78, 1133, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', CAST(N'2016-10-13 13:14:40.837' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (79, 1133, N'67207c55-b02c-4338-9828-b8c365a07696', CAST(N'2016-10-13 13:15:48.480' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (80, 1134, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', CAST(N'2016-10-13 15:22:51.110' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (81, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', CAST(N'2016-10-13 15:43:33.657' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (82, 1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', CAST(N'2016-10-13 15:44:23.017' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (83, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', CAST(N'2016-10-13 15:47:56.687' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (84, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', CAST(N'2016-10-13 16:05:15.743' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (85, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', CAST(N'2016-10-13 16:06:01.497' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (86, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', CAST(N'2016-10-13 16:06:46.550' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (87, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', CAST(N'2016-10-13 16:29:34.073' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (88, 1141, N'e20de96c-7af4-42ce-84cb-85c1a4980a50', CAST(N'2016-10-13 17:39:39.750' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (89, 1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', CAST(N'2016-10-13 17:48:09.193' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (90, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', CAST(N'2016-10-13 17:56:05.430' AS DateTime))
SET IDENTITY_INSERT [dbo].[cmsContentVersion] OFF
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1075, N'<homePage id="1075" key="e091bb6f-7c49-4239-9b23-0eca81cad716" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-20T09:40:49" updateDate="2016-10-13T17:56:05" nodeName="Site" urlName="site" path="-1,1075" isDoc="" nodeType="1050" creatorName="elias" writerName="elias" writerID="0" template="1101" nodeTypeAlias="homePage"><UmbracoNaviHide>0</UmbracoNaviHide><quote1><![CDATA[Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back]]></quote1><footer><![CDATA[unending contact thing]]></footer><quote3><![CDATA[New things on the world of programming]]></quote3><frontpageText><![CDATA[<p><strong>Welcome to Århus WebDevCoop</strong></p>
<p> </p>
<p style="padding-left: 30px;">Here you can enjoy and talk with other people abotu whats going on in the programming comunity</p>]]></frontpageText><header><![CDATA[WebDev community]]></header><quote2><![CDATA[The site is live, all are welcome]]></quote2></homePage>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1088, N'<prospect id="1088" key="505ce24e-781b-4308-89b2-5cf3cebdd82a" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-26T09:33:42" updateDate="2016-10-13T17:40:05" nodeName="Daniel" urlName="daniel" path="-1,1088" isDoc="" nodeType="1087" nodeTypeAlias="prospect" loginName="daniel" email="daniel@musik.com" icon="icon-user"><firstname><![CDATA[Daniel]]></firstname><lastname><![CDATA[Adler]]></lastname><phoneNr><![CDATA[54784512]]></phoneNr><umbracoMemberFailedPasswordAttempts><![CDATA[0]]></umbracoMemberFailedPasswordAttempts><umbracoMemberApproved>1</umbracoMemberApproved><umbracoMemberLockedOut>0</umbracoMemberLockedOut><umbracoMemberLastLogin><![CDATA[10/13/2016 5:40:05 PM]]></umbracoMemberLastLogin><umbracoMemberLastPasswordChangeDate><![CDATA[10/13/2016 1:33:50 PM]]></umbracoMemberLastPasswordChangeDate></prospect>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1089, N'<Member id="1089" key="04ff81ec-8a67-45fc-a04c-6967feb55311" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2016-09-26T09:38:17" updateDate="2016-10-13T17:46:20" nodeName="Elias" urlName="elias" path="-1,1089" isDoc="" nodeType="1044" nodeTypeAlias="Member" loginName="elias" email="elias.v.hansen@gmail.com" icon="icon-user"><firstName><![CDATA[Elias]]></firstName><lastName><![CDATA[Hansen]]></lastName><address><![CDATA[Søndre ringgade 63]]></address><zipcode><![CDATA[8000]]></zipcode><city><![CDATA[Århus C]]></city><phoneNr><![CDATA[50988305]]></phoneNr><avatar><![CDATA[{
  "focalPoint": {
    "left": 0.5,
    "top": 0.5
  },
  "src": "/media/1003/person2.jpg",
  "crops": [
    {
      "alias": "normal",
      "width": 400,
      "height": 700
    },
    {
      "alias": "article",
      "width": 700,
      "height": 500
    }
  ]
}]]></avatar></Member>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1090, N'<Member id="1090" key="92ccf9aa-3f09-4ddc-b67b-ba1cca8274a5" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2016-09-26T09:40:51" updateDate="2016-10-13T17:42:35" nodeName="Barlach" urlName="barlach" path="-1,1090" isDoc="" nodeType="1044" nodeTypeAlias="Member" loginName="Barlach" email="barlach@voss.com" icon="icon-user"><firstName><![CDATA[Christian]]></firstName><lastName><![CDATA[Barlach]]></lastName><address><![CDATA[somewhere]]></address><zipcode><![CDATA[0000]]></zipcode><city><![CDATA[elsewhere]]></city><phoneNr><![CDATA[666333]]></phoneNr><avatar><![CDATA[{
  "focalPoint": {
    "left": 0.5,
    "top": 0.5
  },
  "src": "/media/1004/person.jpg",
  "crops": [
    {
      "alias": "normal",
      "width": 400,
      "height": 700
    },
    {
      "alias": "article",
      "width": 700,
      "height": 500
    }
  ]
}]]></avatar></Member>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1092, N'<textPage id="1092" key="1ff39837-1d04-4a1f-9ce3-ad081b0d64cf" parentID="1075" level="2" creatorID="0" sortOrder="2" createDate="2016-09-26T09:47:42" updateDate="2016-10-12T04:10:55" nodeName="Login" urlName="login" path="-1,1075,1092" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1113" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageMain><![CDATA[<p>Login to our website to get the full experience</p>]]></textPageMain><textPageHeader><![CDATA[Login Page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1094, N'<textPage id="1094" key="95b0692a-1994-46e7-82cf-99e124171574" parentID="1075" level="2" creatorID="0" sortOrder="3" createDate="2016-09-26T10:22:03" updateDate="2016-10-13T17:48:09" nodeName="Forbidden Acess" urlName="forbidden-acess" path="-1,1075,1094" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1142" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageMain><![CDATA[<p>You cannot acces this page, login, or contact us for acces to our website</p>]]></textPageMain><textPageHeader><![CDATA[You are not allowed on the page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1108, N'<textPage id="1108" key="b600d7e3-ee5e-4f05-9781-9cfabddd753c" parentID="1075" level="2" creatorID="0" sortOrder="5" createDate="2016-10-10T11:21:46" updateDate="2016-10-11T21:48:44" nodeName="Contact Us" urlName="contact-us" path="-1,1075,1108" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1111" nodeTypeAlias="textPage"><UmbracoNaviHide>0</UmbracoNaviHide></textPage>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1112, N'<aboutPage id="1112" key="ad5cacc4-f152-440e-8455-a8dc5d0c3042" parentID="1075" level="2" creatorID="0" sortOrder="6" createDate="2016-10-10T11:30:01" updateDate="2016-10-12T14:28:02" nodeName="About" urlName="about" path="-1,1075,1112" isDoc="" nodeType="1110" creatorName="elias" writerName="elias" writerID="0" template="1109" nodeTypeAlias="aboutPage"><UmbracoNaviHide>0</UmbracoNaviHide><aboutGrid><![CDATA[{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>This site is focusing on the new technologies in the development world, we strive to educate people and give people the chance to become a part of a larger society and explore the new things that are sterring in the programming world.</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90",
          "active": false
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>Our vission is to assemble a creat team of programmers to share projects and experience and together widen our collective horison to become better at our jobs, and create the future in programming</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>We seek people who are passionate about programming and strives to learn new things but also share their experince with others.</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Your skills to join this awesome team could be anything from Android to PHP we want a wide net of programmers to share as much knowledge as possible</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": true
                }
              ],
              "active": true,
              "hasActiveChild": true
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "hasActiveChild": true,
          "active": true
        }
      ]
    }
  ]
}]]></aboutGrid></aboutPage>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1119, N'<articleMain id="1119" key="f2ff3436-9469-4ba6-8fd3-6aa396e29f08" parentID="1075" level="2" creatorID="0" sortOrder="7" createDate="2016-10-11T20:14:05" updateDate="2016-10-11T21:49:09" nodeName="Articles" urlName="articles" path="-1,1075,1119" isDoc="" nodeType="1052" creatorName="elias" writerName="elias" writerID="0" template="1104" nodeTypeAlias="articleMain"><UmbracoNaviHide>0</UmbracoNaviHide><articlesHeader><![CDATA[Articles for your learning pleasure]]></articlesHeader><articlesText><![CDATA[<p>Here you can read up on new exiting things that happens in the programming world, and read about some of the projects which is going on.</p>]]></articlesText></articleMain>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1120, N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-12T14:39:12" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1102" nodeTypeAlias="projectMain"><UmbracoNaviHide>0</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1121, N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:31:02" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p><img src="/media/1001/angular-2-features.png?width=500&amp;height=270.5882352941177" alt="" rel="1127" data-id="1127" /></p>
<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview></articleItem>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1122, N'<articleItem id="1122" key="12f925b4-4fdb-4b5d-9f6d-5a576cad4ef2" parentID="1119" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:16:51" updateDate="2016-10-11T21:49:03" nodeName="NodeJS" urlName="nodejs" path="-1,1075,1119,1122" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[NodeJS - The future?]]></articleHeader><articleMainText><![CDATA[<p>Is this the future</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1123, N'<projectsItem id="1123" key="30f52ed6-fac9-4e15-aec4-14eae99e7635" parentID="1120" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:17:32" updateDate="2016-10-13T16:06:46" nodeName="Umbraco mandatory" urlName="umbraco-mandatory" path="-1,1075,1120,1123" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><preview><![CDATA[This project is a small fun project to show of what umbraco can be used for.]]></preview><projectHeader><![CDATA[WebDev Coop Århus]]></projectHeader><projectText><![CDATA[<p>This site is now live and you can check out the project below</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1124, N'<projectsItem id="1124" key="7f9f0597-32b7-438b-8ceb-41d57d77b1bf" parentID="1120" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:18:26" updateDate="2016-10-13T16:06:01" nodeName="Android shoppinglist" urlName="android-shoppinglist" path="-1,1075,1120,1124" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Under Development]]></projectStatus><preview><![CDATA[Android shoppinglist with hookup to firebase for a more comfortable experience]]></preview><projectHeader><![CDATA[A shoppinglist for Android]]></projectHeader><projectText><![CDATA[<p>Check out the code below and make your own changes</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1127, N'<Image id="1127" key="33427bf8-2b83-43ce-a52b-374dc818c0ec" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-10-12T12:05:45" updateDate="2016-10-12T12:05:45" nodeName="Angular-2-features.png" urlName="angular-2-featurespng" path="-1,1127" isDoc="" nodeType="1032" writerName="elias" writerID="0" version="443c67e8-1954-4583-858b-8cf7ffd0e612" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{src: ''/media/1001/angular-2-features.png'', crops: []}]]></umbracoFile><umbracoWidth><![CDATA[850]]></umbracoWidth><umbracoHeight><![CDATA[460]]></umbracoHeight><umbracoBytes><![CDATA[117648]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1133, N'<boardMessages id="1133" key="b30049d5-eb25-4c2a-9b37-1836c658421f" parentID="1075" level="2" creatorID="0" sortOrder="9" createDate="2016-10-13T13:14:40" updateDate="2016-10-13T13:15:48" nodeName="MessageBoard" urlName="messageboard" path="-1,1075,1133" isDoc="" nodeType="1126" creatorName="elias" writerName="elias" writerID="0" template="1132" nodeTypeAlias="boardMessages"><UmbracoNaviHide>0</UmbracoNaviHide><title><![CDATA[Keep yourself updated!]]></title></boardMessages>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1134, N'<boardMessage id="1134" key="d01aabaa-b578-4325-8105-3d2cf309017d" parentID="1133" level="3" creatorID="0" sortOrder="0" createDate="2016-10-13T15:22:51" updateDate="2016-10-13T15:22:51" nodeName="Angular is back" urlName="angular-is-back" path="-1,1075,1133,1134" isDoc="" nodeType="1118" creatorName="elias" writerName="elias" writerID="0" template="1132" nodeTypeAlias="boardMessage"><content><![CDATA[something something]]></content><date>2016-10-13T15:22:51.0855378</date><title><![CDATA[Angular is back]]></title><publisher><![CDATA[daniel]]></publisher></boardMessage>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1135, N'<projectsItem id="1135" key="0eae9b80-5d00-45d3-b93b-9dc46b6a7feb" parentID="1120" level="3" creatorID="0" sortOrder="2" createDate="2016-10-13T16:29:34" updateDate="2016-10-13T16:29:34" nodeName="M.E.A.N Stack solution" urlName="mean-stack-solution" path="-1,1075,1120,1135" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><preview><![CDATA[Mongo, Express, Angular, NodeJS]]></preview><projectHeader><![CDATA[The MEAN stack]]></projectHeader><projectText><![CDATA[<p>Learn about mean stacks and what they have to offer</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1141, N'<memberView id="1141" key="79a1196e-b387-4317-b74f-b9e55d440f6e" parentID="1075" level="2" creatorID="0" sortOrder="10" createDate="2016-10-13T17:39:39" updateDate="2016-10-13T17:39:39" nodeName="Members" urlName="members" path="-1,1075,1141" isDoc="" nodeType="1139" creatorName="elias" writerName="elias" writerID="0" template="1140" nodeTypeAlias="memberView"><UmbracoNaviHide>0</UmbracoNaviHide></memberView>')
SET IDENTITY_INSERT [dbo].[cmsDataType] ON 

INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-28, -97, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-27, -96, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-26, -95, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (1, -49, N'Umbraco.TrueFalse', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (2, -51, N'Umbraco.Integer', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (3, -87, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (4, -88, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (5, -89, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (6, -90, N'Umbraco.UploadField', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (7, -92, N'Umbraco.NoEdit', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (8, -36, N'Umbraco.DateTime', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (9, -37, N'Umbraco.ColorPickerAlias', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (11, -39, N'Umbraco.DropDownMultiple', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (12, -40, N'Umbraco.RadioButtonList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (13, -41, N'Umbraco.Date', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (14, -42, N'Umbraco.DropDown', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (15, -43, N'Umbraco.CheckBoxList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (16, 1034, N'Umbraco.ContentPickerAlias', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (17, 1035, N'Umbraco.MultipleMediaPicker', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (18, 1036, N'Umbraco.MemberPicker', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (21, 1040, N'Umbraco.RelatedLinks', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (22, 1041, N'Umbraco.Tags', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (24, 1043, N'Umbraco.ImageCropper', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (25, 1045, N'Umbraco.MultipleMediaPicker', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (26, 1046, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (27, 1047, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (28, 1053, N'Umbraco.MultipleMediaPicker', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (29, 1056, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (30, 1060, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (31, 1061, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (32, 1062, N'Umbraco.DropDown', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (33, 1063, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (34, 1064, N'Umbraco.UploadField', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (35, 1065, N'Umbraco.MultipleMediaPicker', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (36, 1068, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (37, 1069, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (38, 1072, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (39, 1073, N'Umbraco.UploadField', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (40, 1074, N'Umbraco.MultipleMediaPicker', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (41, 1084, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (42, 1085, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (43, 1086, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (44, 1095, N'Umbraco.TrueFalse', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (45, 1096, N'Umbraco.TrueFalse', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (46, 1107, N'Umbraco.Grid', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (47, 1114, N'Umbraco.DateTime', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (48, 1115, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (49, 1116, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (50, 1128, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (51, 1129, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (52, 1136, N'Umbraco.EmailAddress', N'Nvarchar')
SET IDENTITY_INSERT [dbo].[cmsDataType] OFF
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] ON 

INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-9, -96, N'[{"alias":"updateDate","header":"Last edited","isSystem":1},{"alias":"owner","header":"Updated by","isSystem":1}]', 5, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-8, -96, N'[{"name": "Grid","path": "views/propertyeditors/listview/layouts/grid/grid.html", "icon": "icon-thumbnails-small", "isSystem": 1, "selected": true},{"name": "List","path": "views/propertyeditors/listview/layouts/list/list.html","icon": "icon-list", "isSystem": 1,"selected": true}]', 4, N'layouts')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-7, -96, N'desc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-6, -96, N'updateDate', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-5, -96, N'100', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-4, -97, N'[{"alias":"username","isSystem":1},{"alias":"email","isSystem":1},{"alias":"updateDate","header":"Last edited","isSystem":1}]', 4, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-3, -97, N'asc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-2, -97, N'username', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-1, -97, N'10', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (3, -87, N',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|', 0, N'')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (4, 1041, N'default', 0, N'group')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (5, 1045, N'1', 0, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (6, 1053, NULL, 1, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (7, 1053, N'1', 2, N'onlyImages')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (8, 1053, NULL, 3, N'disableFolderSelect')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (9, 1053, N'', 4, N'startNodeId')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (10, 1056, N'{
  "toolbar": [
    "code",
    "styleselect",
    "bold",
    "italic",
    "alignleft",
    "aligncenter",
    "alignright",
    "bullist",
    "numlist",
    "outdent",
    "indent",
    "link",
    "umbmediapicker",
    "umbmacro",
    "umbembeddialog"
  ],
  "stylesheets": [],
  "dimensions": {
    "height": 500
  },
  "maxImageSize": 500
}', 1, N'editor')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (11, 1056, NULL, 2, N'hideLabel')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (12, 1062, N'Idea', 1, N'0')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (13, 1062, N'Initiated', 2, N'1')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (14, 1062, N'Under Development', 3, N'2')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (15, 1062, N'Completed', 4, N'3')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (16, 1064, N'', 1, N'thumbs')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (17, 1065, NULL, 1, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (18, 1065, N'1', 2, N'onlyImages')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (19, 1065, NULL, 3, N'disableFolderSelect')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (20, 1065, N'', 4, N'startNodeId')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (21, 1069, N'{
  "toolbar": [
    "code",
    "styleselect",
    "bold",
    "italic",
    "alignleft",
    "aligncenter",
    "alignright",
    "bullist",
    "numlist",
    "outdent",
    "indent",
    "link",
    "umbmediapicker",
    "umbmacro",
    "umbembeddialog"
  ],
  "stylesheets": [],
  "dimensions": {
    "height": 500
  },
  "maxImageSize": 500
}', 1, N'editor')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (22, 1069, NULL, 2, N'hideLabel')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (23, 1072, N'{
  "toolbar": [
    "code",
    "styleselect",
    "bold",
    "italic",
    "alignleft",
    "aligncenter",
    "alignright",
    "bullist",
    "numlist",
    "outdent",
    "indent",
    "link",
    "umbmediapicker",
    "umbmacro",
    "umbembeddialog"
  ],
  "stylesheets": [],
  "dimensions": {
    "height": 500
  },
  "maxImageSize": 500
}', 1, N'editor')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (24, 1072, NULL, 2, N'hideLabel')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (25, 1073, N'', 1, N'thumbs')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (26, 1074, NULL, 1, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (27, 1074, N'1', 2, N'onlyImages')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (28, 1074, NULL, 3, N'disableFolderSelect')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (29, 1074, N'', 4, N'startNodeId')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (31, 1095, NULL, 1, N'default')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (32, 1096, NULL, 1, N'default')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (37, 1114, N'0', 1, N'offsetTime')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (38, 1114, N'YYYY-MM-DD HH:mm:ss', 2, N'format')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (42, 1043, N'[
  {
    "alias": "normal",
    "width": 400,
    "height": 700
  },
  {
    "alias": "article",
    "width": 700,
    "height": 500
  }
]', 1, N'crops')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (43, 1107, N'{
  "styles": [
    {
      "label": "Set a background image",
      "description": "Set a row background",
      "key": "background-image",
      "view": "imagepicker",
      "modifier": "url({0})"
    }
  ],
  "config": [
    {
      "label": "Class",
      "description": "Set a css class",
      "key": "class",
      "view": "textstring"
    }
  ],
  "columns": 12,
  "templates": [
    {
      "name": "contactGrid",
      "sections": [
        {
          "grid": 12
        }
      ]
    }
  ],
  "layouts": [
    {
      "name": "Headline",
      "areas": [
        {
          "grid": 12,
          "editors": [
            "headline"
          ]
        }
      ]
    },
    {
      "name": "Article",
      "areas": [
        {
          "grid": 4
        },
        {
          "grid": 8
        }
      ]
    },
    {
      "name": "3colum",
      "areas": [
        {
          "grid": 4,
          "allowAll": true
        },
        {
          "grid": 4
        },
        {
          "grid": 4,
          "allowAll": false
        }
      ]
    }
  ]
}', 1, N'items')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (44, 1107, N'{
  "toolbar": [
    "code",
    "styleselect",
    "bold",
    "italic",
    "alignleft",
    "aligncenter",
    "alignright",
    "bullist",
    "numlist",
    "outdent",
    "indent",
    "link",
    "umbmediapicker",
    "umbmacro",
    "umbembeddialog"
  ],
  "stylesheets": [],
  "dimensions": {
    "height": 500
  },
  "maxImageSize": 500
}', 2, N'rte')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (45, 1136, NULL, 1, N'IsRequired')
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] OFF
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:23:02.477' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1079, 0, 0, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', N'Socket.IO', NULL, NULL, CAST(N'2016-09-20 09:47:51.207' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1093, 0, 0, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', N'MEAN Stack', NULL, NULL, CAST(N'2016-10-11 20:12:49.323' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1080, 0, 0, N'782206b6-d271-4e94-ad5f-0c861234ceca', N'Chat application', NULL, NULL, CAST(N'2016-10-10 10:49:35.920' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 0, 0, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', N'Projects', NULL, NULL, CAST(N'2016-10-12 04:00:31.360' AS DateTime), 1102, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1081, 0, 0, N'171ef749-85d4-4109-a0f7-1148237d7678', N'Learning Umbraco', NULL, NULL, CAST(N'2016-09-20 09:50:31.570' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1123, 0, 0, N'7a6270a7-fd9a-4055-95da-11e943194a4c', N'Umbraco mandatory', NULL, NULL, CAST(N'2016-10-11 20:17:32.320' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1093, 0, 0, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', N'MEAN Stack', NULL, NULL, CAST(N'2016-09-26 09:49:06.313' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1075, 1, 0, N'52684f31-d806-4495-8d64-1dd500ecd8ce', N'Site', NULL, NULL, CAST(N'2016-10-13 17:56:05.430' AS DateTime), 1101, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1123, 1, 0, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', N'Umbraco mandatory', NULL, NULL, CAST(N'2016-10-13 16:06:46.550' AS DateTime), 1103, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1079, 0, 0, N'452ea599-c859-476a-b38a-26772fbdbbd1', N'Socket.IO', NULL, NULL, CAST(N'2016-10-11 20:12:49.253' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1112, 0, 0, N'5195df88-ac00-4072-979f-2ef3464d1b71', N'About', NULL, NULL, CAST(N'2016-10-12 14:22:26.080' AS DateTime), 1109, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1075, 0, 0, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', N'Site', NULL, NULL, CAST(N'2016-10-13 15:47:56.687' AS DateTime), 1101, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1077, 0, 0, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', N'Projects', NULL, NULL, CAST(N'2016-09-20 09:43:24.850' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1075, 0, 0, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', N'Site', NULL, NULL, CAST(N'2016-10-13 15:43:33.657' AS DateTime), 1101, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1078, 0, 0, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', N'MongoDB', NULL, NULL, CAST(N'2016-10-11 20:12:49.330' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1076, 0, 0, N'd61239b7-9426-4b8d-b880-364f822f0974', N'Articles', NULL, NULL, CAST(N'2016-10-11 20:12:48.887' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1077, 0, 0, N'ff5c19c1-988a-4462-97cb-36949b2aa670', N'Projects', NULL, NULL, CAST(N'2016-10-11 20:12:54.307' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1108, 0, 0, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', N'About Us', NULL, NULL, CAST(N'2016-10-10 11:21:46.997' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1135, 1, 0, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', N'M.E.A.N Stack solution', NULL, NULL, CAST(N'2016-10-13 16:29:34.073' AS DateTime), 1103, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'e19c10e4-23a5-4924-895b-49015e351fc4', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:14:48.383' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1131, 0, 0, N'b6170db1-3fe7-46a2-808b-49286e309ec0', N'Angular', NULL, NULL, CAST(N'2016-10-13 13:12:39.113' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:26:32.683' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 1, 0, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', N'Projects', NULL, NULL, CAST(N'2016-10-12 14:39:12.277' AS DateTime), 1102, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1131, 0, 0, N'cbe2c390-9d41-425f-819e-58bab291c22e', N'Angular', NULL, NULL, CAST(N'2016-10-12 16:41:31.987' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1092, 0, 0, N'62209e30-c43f-4767-818d-5c6d553d25fa', N'Login', NULL, NULL, CAST(N'2016-09-26 09:47:42.117' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1094, 0, 0, N'618a9998-139a-49b9-bd29-5cb6a55152a9', N'Forbidden Acess', NULL, NULL, CAST(N'2016-10-13 15:44:23.017' AS DateTime), 1106, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1130, 0, 0, N'e1fd8011-22c5-47ab-ad89-5e19ca24b410', N'Messageboard', NULL, NULL, CAST(N'2016-10-13 13:12:38.697' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1130, 0, 0, N'aad9bf99-da5c-45c2-834d-6163a51d007b', N'Messageboard', NULL, NULL, CAST(N'2016-10-12 16:40:13.070' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', N'Angular 2', NULL, NULL, CAST(N'2016-10-11 21:48:57.630' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1131, 0, 0, N'd3cb6479-f887-410b-ba90-6b59c7a3a8b5', N'Angular', NULL, NULL, CAST(N'2016-10-13 13:12:39.210' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1122, 1, 0, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', N'NodeJS', NULL, NULL, CAST(N'2016-10-11 21:49:03.553' AS DateTime), 1105, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1092, 0, 0, N'8d38e053-a525-4e65-b76d-6e1687109392', N'Login', NULL, NULL, CAST(N'2016-10-11 21:48:30.220' AS DateTime), 1106, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1123, 0, 0, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', N'Umbraco mandatory', NULL, NULL, CAST(N'2016-10-13 16:05:15.743' AS DateTime), 1103, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1076, 0, 0, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', N'Articles', NULL, NULL, CAST(N'2016-09-20 09:42:22.107' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1081, 0, 0, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', N'Learning Umbraco', NULL, NULL, CAST(N'2016-10-11 20:12:54.387' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1130, 0, 0, N'e7c8c962-e52e-401f-a621-7457aef2f1be', N'Messageboard', NULL, NULL, CAST(N'2016-10-13 13:12:39.183' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:10:52.943' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1123, 0, 0, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', N'Umbraco mandatory', NULL, NULL, CAST(N'2016-10-12 03:30:55.630' AS DateTime), 1103, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 0, 0, N'11c056da-bd0a-42a3-932c-80c77f58574f', N'Projects', NULL, NULL, CAST(N'2016-10-11 21:49:21.613' AS DateTime), 1102, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1141, 1, 0, N'e20de96c-7af4-42ce-84cb-85c1a4980a50', N'Members', NULL, NULL, CAST(N'2016-10-13 17:39:39.750' AS DateTime), 1140, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1112, 0, 0, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', N'About', NULL, NULL, CAST(N'2016-10-10 11:30:01.787' AS DateTime), 1109, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1112, 0, 0, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', N'About', NULL, NULL, CAST(N'2016-10-11 21:48:49.367' AS DateTime), 1109, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1122, 0, 0, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', N'NodeJS', NULL, NULL, CAST(N'2016-10-11 20:16:51.987' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1094, 0, 0, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', N'Forbidden Acess', NULL, NULL, CAST(N'2016-09-26 10:56:39.127' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1112, 1, 0, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', N'About', NULL, NULL, CAST(N'2016-10-12 14:28:02.067' AS DateTime), 1109, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1080, 0, 0, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', N'Chat application', NULL, NULL, CAST(N'2016-10-11 20:12:54.380' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1092, 0, 0, N'5869c7f2-b682-4cf8-9b95-940297d10743', N'Login', NULL, NULL, CAST(N'2016-10-12 03:26:11.913' AS DateTime), 1106, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1093, 0, 0, N'a13de735-8528-4377-b37a-95fb684c278e', N'MEAN Stack', NULL, NULL, CAST(N'2016-10-11 20:12:49.223' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', N'Angular 2', NULL, NULL, CAST(N'2016-10-11 20:16:21.560' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1080, 0, 0, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', N'Chat application', NULL, NULL, CAST(N'2016-09-20 09:49:40.150' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1123, 0, 0, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', N'Umbraco mandatory', NULL, NULL, CAST(N'2016-10-11 20:17:45.343' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1133, 0, 0, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', N'MessageBoard', NULL, NULL, CAST(N'2016-10-13 13:14:40.837' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1078, 0, 0, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', N'MongoDB', NULL, NULL, CAST(N'2016-10-11 20:12:49.290' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1094, 1, 0, N'25156fe2-813f-496f-8f9d-a963c7087e8b', N'Forbidden Acess', NULL, NULL, CAST(N'2016-10-13 17:48:09.193' AS DateTime), 1142, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'10b19b23-5174-4bb6-960e-ad887191ee8a', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:10:27.473' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1124, 1, 0, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', N'Android shoppinglist', NULL, NULL, CAST(N'2016-10-13 16:06:01.497' AS DateTime), 1103, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1119, 1, 0, N'10351876-5e24-473a-940c-afe9f0b7af17', N'Articles', NULL, NULL, CAST(N'2016-10-11 21:49:09.020' AS DateTime), 1104, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 1, 0, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:31:02.387' AS DateTime), 1105, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1079, 0, 0, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', N'Socket.IO', NULL, NULL, CAST(N'2016-10-11 20:12:49.327' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1133, 1, 0, N'67207c55-b02c-4338-9828-b8c365a07696', N'MessageBoard', NULL, NULL, CAST(N'2016-10-13 13:15:48.480' AS DateTime), 1132, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1134, 1, 0, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', N'Angular is back', NULL, NULL, CAST(N'2016-10-13 15:22:51.110' AS DateTime), 1132, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1094, 0, 0, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', N'Forbidden Acess', NULL, NULL, CAST(N'2016-10-11 21:48:37.653' AS DateTime), 1106, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1092, 1, 0, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', N'Login', NULL, NULL, CAST(N'2016-10-12 04:10:55.370' AS DateTime), 1113, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1075, 0, 0, N'ff44be02-79d9-4056-a867-bc97af070b3c', N'Site', NULL, NULL, CAST(N'2016-09-20 09:40:49.340' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1081, 0, 0, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', N'Learning Umbraco', NULL, NULL, CAST(N'2016-10-11 20:12:54.357' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1108, 1, 0, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', N'Contact Us', NULL, NULL, CAST(N'2016-10-11 21:48:44.363' AS DateTime), 1111, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1112, 0, 0, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', N'About', NULL, NULL, CAST(N'2016-10-12 14:22:21.713' AS DateTime), 1109, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1119, 0, 0, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', N'Articles', NULL, NULL, CAST(N'2016-10-11 20:14:05.620' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1077, 0, 0, N'0168e231-864a-4863-862c-cf8541ff5a61', N'Projects', NULL, NULL, CAST(N'2016-10-11 20:12:54.373' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1076, 0, 0, N'e7929ac3-bebc-4801-8788-d249c4fdf418', N'Articles', NULL, NULL, CAST(N'2016-10-11 20:12:49.313' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1124, 0, 0, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', N'Android shoppinglist', NULL, NULL, CAST(N'2016-10-11 21:49:35.923' AS DateTime), 1103, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:05:55.450' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1124, 0, 0, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', N'Android shoppinglist', NULL, NULL, CAST(N'2016-10-11 20:18:26.347' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 0, 0, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', N'Projects', NULL, NULL, CAST(N'2016-10-11 20:15:47.047' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 0, 0, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', N'Projects', NULL, NULL, CAST(N'2016-10-12 04:01:34.930' AS DateTime), 1102, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1108, 0, 0, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', N'Contact Us', NULL, NULL, CAST(N'2016-10-10 11:28:27.763' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1121, 0, 0, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', N'Angular 2', NULL, NULL, CAST(N'2016-10-12 12:23:49.723' AS DateTime), 1105, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1075, 0, 0, N'4cff21d5-43be-47de-967e-e2de667ff4b6', N'Site', NULL, NULL, CAST(N'2016-10-10 10:11:15.233' AS DateTime), 1101, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 0, 0, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', N'Projects', NULL, NULL, CAST(N'2016-10-12 04:01:03.100' AS DateTime), 1102, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1080, 0, 0, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', N'Chat application', NULL, NULL, CAST(N'2016-10-11 20:12:54.333' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1094, 0, 0, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', N'Forbidden Acess', NULL, NULL, CAST(N'2016-09-26 10:22:03.007' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1078, 0, 0, N'b6309d03-0d98-4814-b461-fa4b867c6477', N'MongoDB', NULL, NULL, CAST(N'2016-09-20 09:46:50.900' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1120, 0, 0, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', N'Projects', NULL, NULL, CAST(N'2016-10-11 20:15:05.613' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1050, 1101, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1052, 1104, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1055, 1105, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1058, 1106, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1058, 1111, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1058, 1113, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1058, 1142, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1067, 1102, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1071, 1103, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1110, 1109, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1118, 1132, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1126, 1132, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1139, 1140, 1)
SET IDENTITY_INSERT [dbo].[cmsMacro] ON 

INSERT [dbo].[cmsMacro] ([id], [macroUseInEditor], [macroRefreshRate], [macroAlias], [macroName], [macroScriptType], [macroScriptAssembly], [macroXSLT], [macroCacheByPage], [macroCachePersonalized], [macroDontRender], [macroPython]) VALUES (1, 0, 0, N'MainNavi', N'MainNavi', N'', N'', N'', 0, 0, 1, N'~/Views/MacroPartials/MainNavi.cshtml')
INSERT [dbo].[cmsMacro] ([id], [macroUseInEditor], [macroRefreshRate], [macroAlias], [macroName], [macroScriptType], [macroScriptAssembly], [macroXSLT], [macroCacheByPage], [macroCachePersonalized], [macroDontRender], [macroPython]) VALUES (2, 0, 0, N'ChildList', N'ChildList', N'', N'', N'', 0, 0, 1, N'~/Views/MacroPartials/ChildList.cshtml')
INSERT [dbo].[cmsMacro] ([id], [macroUseInEditor], [macroRefreshRate], [macroAlias], [macroName], [macroScriptType], [macroScriptAssembly], [macroXSLT], [macroCacheByPage], [macroCachePersonalized], [macroDontRender], [macroPython]) VALUES (3, 1, 0, N'Login', N'Login', N'', N'', N'', 0, 0, 1, N'~/Views/MacroPartials/Login.cshtml')
SET IDENTITY_INSERT [dbo].[cmsMacro] OFF
INSERT [dbo].[cmsMember] ([nodeId], [Email], [LoginName], [Password]) VALUES (1088, N'daniel@musik.com', N'daniel', N'zIovv4m7Uh6l864X4FbQwSt7Kbw=')
INSERT [dbo].[cmsMember] ([nodeId], [Email], [LoginName], [Password]) VALUES (1089, N'elias.v.hansen@gmail.com', N'elias', N'Pp6F96l0j2PHMhNyn5WU4dWRQsY=')
INSERT [dbo].[cmsMember] ([nodeId], [Email], [LoginName], [Password]) VALUES (1090, N'barlach@voss.com', N'Barlach', N'7/wRkvjiy5FYvs7egqx7OB0/qRk=')
INSERT [dbo].[cmsMember2MemberGroup] ([Member], [MemberGroup]) VALUES (1088, 1083)
INSERT [dbo].[cmsMember2MemberGroup] ([Member], [MemberGroup]) VALUES (1089, 1082)
INSERT [dbo].[cmsMember2MemberGroup] ([Member], [MemberGroup]) VALUES (1090, 1082)
SET IDENTITY_INSERT [dbo].[cmsMemberType] ON 

INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (29, 1087, 64, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (30, 1087, 65, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (31, 1087, 66, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (32, 1087, 67, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (33, 1087, 68, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (34, 1087, 69, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (35, 1087, 70, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (36, 1087, 71, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (37, 1087, 72, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (38, 1087, 73, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (39, 1087, 74, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (40, 1087, 75, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (41, 1044, 55, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (42, 1044, 56, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (43, 1044, 28, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (44, 1044, 29, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (45, 1044, 30, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (46, 1044, 31, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (47, 1044, 32, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (48, 1044, 33, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (49, 1044, 34, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (50, 1044, 57, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (51, 1044, 58, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (52, 1044, 59, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (53, 1044, 60, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (54, 1044, 61, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (55, 1044, 62, 1, 1)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (56, 1044, 63, 1, 1)
SET IDENTITY_INSERT [dbo].[cmsMemberType] OFF
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', CAST(N'2016-10-13 17:56:05.467' AS DateTime), N'<homePage id="1075" key="e091bb6f-7c49-4239-9b23-0eca81cad716" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-20T09:40:49" updateDate="2016-10-13T17:56:05" nodeName="Site" urlName="site" path="-1,1075" isDoc="" nodeType="1050" creatorName="elias" writerName="elias" writerID="0" template="1101" nodeTypeAlias="homePage"><UmbracoNaviHide>0</UmbracoNaviHide><quote1><![CDATA[Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back]]></quote1><footer><![CDATA[unending contact thing]]></footer><quote3><![CDATA[New things on the world of programming]]></quote3><frontpageText><![CDATA[<p><strong>Welcome to Århus WebDevCoop</strong></p>
<p> </p>
<p style="padding-left: 30px;">Here you can enjoy and talk with other people abotu whats going on in the programming comunity</p>]]></frontpageText><header><![CDATA[WebDev community]]></header><quote2><![CDATA[The site is live, all are welcome]]></quote2></homePage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', CAST(N'2016-10-13 15:47:56.713' AS DateTime), N'<homePage id="1075" key="e091bb6f-7c49-4239-9b23-0eca81cad716" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-20T09:40:49" updateDate="2016-10-13T15:47:56" nodeName="Site" urlName="site" path="-1,1075" isDoc="" nodeType="1050" creatorName="elias" writerName="elias" writerID="0" template="1101" nodeTypeAlias="homePage"><UmbracoNaviHide>0</UmbracoNaviHide><quote1><![CDATA[Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back]]></quote1><footer><![CDATA[unending contact thing]]></footer><quote3><![CDATA[New things on the world of programming]]></quote3><frontpageText><![CDATA[<p>Welcome to Århus WebDevCoop this is wierd</p>]]></frontpageText><header><![CDATA[WebDev community]]></header><quote2><![CDATA[The site is live, all are welcome]]></quote2></homePage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', CAST(N'2016-10-13 15:43:33.700' AS DateTime), N'<homePage id="1075" key="e091bb6f-7c49-4239-9b23-0eca81cad716" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-20T09:40:49" updateDate="2016-10-13T15:43:33" nodeName="Site" urlName="site" path="-1,1075" isDoc="" nodeType="1050" creatorName="elias" writerName="elias" writerID="0" template="1101" nodeTypeAlias="homePage"><UmbracoNaviHide>0</UmbracoNaviHide><quote1><![CDATA[<p>- Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back</p>]]></quote1><footer><![CDATA[unending contact thing]]></footer><frontpageText><![CDATA[<p>Welcome to Århus WebDevCoop this is wierd</p>]]></frontpageText><quote2><![CDATA[<p>This site is up and running Welcome to all</p>]]></quote2><header><![CDATA[WebDev community]]></header></homePage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', CAST(N'2016-09-20 09:40:51.987' AS DateTime), N'<homePage id="1075" key="e091bb6f-7c49-4239-9b23-0eca81cad716" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-20T09:40:49" updateDate="2016-09-20T09:40:49" nodeName="Site" urlName="site" path="-1,1075" isDoc="" nodeType="1050" creatorName="elias" writerName="elias" writerID="0" template="1049" nodeTypeAlias="homePage"><footer><![CDATA[unending contact thing]]></footer><frontpageText><![CDATA[<p>Welcome to Århus WebDevCoop this is wierd</p>]]></frontpageText><header><![CDATA[WebDev community]]></header></homePage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', CAST(N'2016-10-10 10:11:16.173' AS DateTime), N'<homePage id="1075" key="e091bb6f-7c49-4239-9b23-0eca81cad716" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2016-09-20T09:40:49" updateDate="2016-10-10T10:11:15" nodeName="Site" urlName="site" path="-1,1075" isDoc="" nodeType="1050" creatorName="elias" writerName="elias" writerID="0" template="1101" nodeTypeAlias="homePage"><UmbracoNaviHide>0</UmbracoNaviHide><footer><![CDATA[unending contact thing]]></footer><frontpageText><![CDATA[<p>Welcome to Århus WebDevCoop this is wierd</p>]]></frontpageText><header><![CDATA[WebDev community]]></header></homePage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1076, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', CAST(N'2016-09-20 09:42:22.290' AS DateTime), N'<articleMain id="1076" key="ab154a8e-576c-47cb-b6f4-cffd45ea36e2" parentID="1075" level="2" creatorID="0" sortOrder="0" createDate="2016-09-20T09:42:22" updateDate="2016-09-20T09:42:22" nodeName="Articles" urlName="articles" path="-1,1075,1076" isDoc="" nodeType="1052" creatorName="elias" writerName="elias" writerID="0" template="1051" nodeTypeAlias="articleMain"><articlesHeader><![CDATA[Articles]]></articlesHeader><articlesText><![CDATA[<p>Here are some exiting articles for you to read about</p>]]></articlesText></articleMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1077, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', CAST(N'2016-09-20 09:43:25.010' AS DateTime), N'<projectMain id="1077" key="5aa11c39-f62e-4bbb-a5af-352dda551b54" parentID="1075" level="2" creatorID="0" sortOrder="1" createDate="2016-09-20T09:43:24" updateDate="2016-09-20T09:43:24" nodeName="Projects" urlName="projects" path="-1,1075,1077" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1066" nodeTypeAlias="projectMain"><projectsHeader><![CDATA[Projects]]></projectsHeader><projectsDescription><![CDATA[<p>here are some projects that are ongoing on this site, feel free to look at them and contact the developers with ideas</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', CAST(N'2016-09-20 09:46:51.087' AS DateTime), N'<articleItem id="1078" key="b86c9f4c-1990-4a9b-b466-c0e0d5749c56" parentID="1076" level="3" creatorID="0" sortOrder="0" createDate="2016-09-20T09:44:59" updateDate="2016-09-20T09:46:50" nodeName="MongoDB" urlName="mongodb" path="-1,1075,1076,1078" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1054" nodeTypeAlias="articleItem"><articleHeader><![CDATA[Mongo DB]]></articleHeader><articleMainText><![CDATA[<p>Mongo is fast and awesome... HURRAYYY</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', CAST(N'2016-09-20 09:47:52.523' AS DateTime), N'<articleItem id="1079" key="8ab9b575-6e79-4853-9885-77c3b0901161" parentID="1076" level="3" creatorID="0" sortOrder="1" createDate="2016-09-20T09:47:51" updateDate="2016-09-20T09:47:51" nodeName="Socket.IO" urlName="socketio" path="-1,1075,1076,1079" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1054" nodeTypeAlias="articleItem"><articleHeader><![CDATA[Socket Io]]></articleHeader><articleMainText><![CDATA[<p>socket IO is good but we do not learn enough about it</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', CAST(N'2016-10-10 10:49:36.620' AS DateTime), N'<projectsItem id="1080" key="24bd3a64-e12c-4ac4-a5cb-acc462132ba5" parentID="1077" level="3" creatorID="0" sortOrder="0" createDate="2016-09-20T09:49:18" updateDate="2016-10-10T10:49:35" nodeName="Chat application" urlName="chat-application" path="-1,1075,1077,1080" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Under Development]]></projectStatus><projectHeader><![CDATA[Chat with Socket IO]]></projectHeader><projectText><![CDATA[<p>Here are some chat application with socket IO remember to install the npm package</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', CAST(N'2016-09-20 09:49:40.903' AS DateTime), N'<projectsItem id="1080" key="24bd3a64-e12c-4ac4-a5cb-acc462132ba5" parentID="1077" level="3" creatorID="0" sortOrder="0" createDate="2016-09-20T09:49:18" updateDate="2016-09-20T09:49:40" nodeName="Chat application" urlName="chat-application" path="-1,1075,1077,1080" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1070" nodeTypeAlias="projectsItem"><projectStatus><![CDATA[Under Development]]></projectStatus><projectHeader><![CDATA[Chat with Socket IO]]></projectHeader><projectText><![CDATA[<p>Here are some chat application with socket IO remember to install the npm package</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1081, N'171ef749-85d4-4109-a0f7-1148237d7678', CAST(N'2016-09-20 09:50:31.753' AS DateTime), N'<projectsItem id="1081" key="a7158215-7144-4a6f-906c-89f82fbb9a5a" parentID="1077" level="3" creatorID="0" sortOrder="1" createDate="2016-09-20T09:50:31" updateDate="2016-09-20T09:50:31" nodeName="Learning Umbraco" urlName="learning-umbraco" path="-1,1075,1077,1081" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1070" nodeTypeAlias="projectsItem"><projectStatus><![CDATA[Idea]]></projectStatus><projectHeader><![CDATA[Umbraco with MVC]]></projectHeader><projectText><![CDATA[<p>This is how ambraco and MVC can wrk together. good luck</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1092, N'62209e30-c43f-4767-818d-5c6d553d25fa', CAST(N'2016-09-26 09:47:42.527' AS DateTime), N'<textPage id="1092" key="1ff39837-1d04-4a1f-9ce3-ad081b0d64cf" parentID="1075" level="2" creatorID="0" sortOrder="2" createDate="2016-09-26T09:47:42" updateDate="2016-09-26T09:47:42" nodeName="Login" urlName="login" path="-1,1075,1092" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1091" nodeTypeAlias="textPage"><textPageMain><![CDATA[<p>Login to our website to get the full experience</p>]]></textPageMain><textPageHeader><![CDATA[Login Page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1092, N'8d38e053-a525-4e65-b76d-6e1687109392', CAST(N'2016-10-11 21:48:30.260' AS DateTime), N'<textPage id="1092" key="1ff39837-1d04-4a1f-9ce3-ad081b0d64cf" parentID="1075" level="2" creatorID="0" sortOrder="2" createDate="2016-09-26T09:47:42" updateDate="2016-10-11T21:48:30" nodeName="Login" urlName="login" path="-1,1075,1092" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1106" nodeTypeAlias="textPage"><UmbracoNaviHide>0</UmbracoNaviHide><textPageMain><![CDATA[<p>Login to our website to get the full experience</p>]]></textPageMain><textPageHeader><![CDATA[Login Page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', CAST(N'2016-10-12 03:26:11.953' AS DateTime), N'<textPage id="1092" key="1ff39837-1d04-4a1f-9ce3-ad081b0d64cf" parentID="1075" level="2" creatorID="0" sortOrder="2" createDate="2016-09-26T09:47:42" updateDate="2016-10-12T03:26:11" nodeName="Login" urlName="login" path="-1,1075,1092" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1106" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageMain><![CDATA[<p>Login to our website to get the full experience</p>]]></textPageMain><textPageHeader><![CDATA[Login Page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', CAST(N'2016-10-12 04:10:55.390' AS DateTime), N'<textPage id="1092" key="1ff39837-1d04-4a1f-9ce3-ad081b0d64cf" parentID="1075" level="2" creatorID="0" sortOrder="2" createDate="2016-09-26T09:47:42" updateDate="2016-10-12T04:10:55" nodeName="Login" urlName="login" path="-1,1075,1092" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1113" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageMain><![CDATA[<p>Login to our website to get the full experience</p>]]></textPageMain><textPageHeader><![CDATA[Login Page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', CAST(N'2016-09-26 09:49:06.700' AS DateTime), N'<articleItem id="1093" key="b76b368e-60f8-408c-ac50-8816d8ef697a" parentID="1076" level="3" creatorID="0" sortOrder="2" createDate="2016-09-26T09:49:06" updateDate="2016-09-26T09:49:06" nodeName="MEAN Stack" urlName="mean-stack" path="-1,1075,1076,1093" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1054" nodeTypeAlias="articleItem"><articleHeader><![CDATA[M.E.A.N Stack]]></articleHeader><articleMainText><![CDATA[<p>The MEAN stack is awesome</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', CAST(N'2016-10-13 15:44:23.023' AS DateTime), N'<textPage id="1094" key="95b0692a-1994-46e7-82cf-99e124171574" parentID="1075" level="2" creatorID="0" sortOrder="3" createDate="2016-09-26T10:22:03" updateDate="2016-10-13T15:44:23" nodeName="Forbidden Acess" urlName="forbidden-acess" path="-1,1075,1094" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1106" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageMain><![CDATA[<p>You cannot acces this page, login, or contact us for acces to our website</p>]]></textPageMain><textPageHeader><![CDATA[You are not allowed on the page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', CAST(N'2016-09-26 10:56:39.350' AS DateTime), N'<textPage id="1094" key="95b0692a-1994-46e7-82cf-99e124171574" parentID="1075" level="2" creatorID="0" sortOrder="3" createDate="2016-09-26T10:22:03" updateDate="2016-09-26T10:56:39" nodeName="Forbidden Acess" urlName="forbidden-acess" path="-1,1075,1094" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1057" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageHeader><![CDATA[You are not allowed on the page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', CAST(N'2016-10-13 17:48:09.233' AS DateTime), N'<textPage id="1094" key="95b0692a-1994-46e7-82cf-99e124171574" parentID="1075" level="2" creatorID="0" sortOrder="3" createDate="2016-09-26T10:22:03" updateDate="2016-10-13T17:48:09" nodeName="Forbidden Acess" urlName="forbidden-acess" path="-1,1075,1094" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1142" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageMain><![CDATA[<p>You cannot acces this page, login, or contact us for acces to our website</p>]]></textPageMain><textPageHeader><![CDATA[You are not allowed on the page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', CAST(N'2016-10-11 21:48:37.660' AS DateTime), N'<textPage id="1094" key="95b0692a-1994-46e7-82cf-99e124171574" parentID="1075" level="2" creatorID="0" sortOrder="3" createDate="2016-09-26T10:22:03" updateDate="2016-10-11T21:48:37" nodeName="Forbidden Acess" urlName="forbidden-acess" path="-1,1075,1094" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1106" nodeTypeAlias="textPage"><UmbracoNaviHide>1</UmbracoNaviHide><textPageHeader><![CDATA[You are not allowed on the page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1094, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', CAST(N'2016-09-26 10:22:03.853' AS DateTime), N'<textPage id="1094" key="95b0692a-1994-46e7-82cf-99e124171574" parentID="1075" level="2" creatorID="0" sortOrder="3" createDate="2016-09-26T10:22:03" updateDate="2016-09-26T10:22:03" nodeName="Forbidden Acess" urlName="forbidden-acess" path="-1,1075,1094" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1057" nodeTypeAlias="textPage"><textPageHeader><![CDATA[You are not allowed on the page]]></textPageHeader></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', CAST(N'2016-10-10 11:21:48.533' AS DateTime), N'<textPage id="1108" key="b600d7e3-ee5e-4f05-9781-9cfabddd753c" parentID="1075" level="2" creatorID="0" sortOrder="5" createDate="2016-10-10T11:21:46" updateDate="2016-10-10T11:21:46" nodeName="About Us" urlName="about-us" path="-1,1075,1108" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="textPage"><UmbracoNaviHide>0</UmbracoNaviHide></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', CAST(N'2016-10-11 21:48:44.370' AS DateTime), N'<textPage id="1108" key="b600d7e3-ee5e-4f05-9781-9cfabddd753c" parentID="1075" level="2" creatorID="0" sortOrder="5" createDate="2016-10-10T11:21:46" updateDate="2016-10-11T21:48:44" nodeName="Contact Us" urlName="contact-us" path="-1,1075,1108" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="1111" nodeTypeAlias="textPage"><UmbracoNaviHide>0</UmbracoNaviHide></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', CAST(N'2016-10-10 11:28:28.033' AS DateTime), N'<textPage id="1108" key="b600d7e3-ee5e-4f05-9781-9cfabddd753c" parentID="1075" level="2" creatorID="0" sortOrder="5" createDate="2016-10-10T11:21:46" updateDate="2016-10-10T11:28:27" nodeName="Contact Us" urlName="contact-us" path="-1,1075,1108" isDoc="" nodeType="1058" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="textPage"><UmbracoNaviHide>0</UmbracoNaviHide></textPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1112, N'5195df88-ac00-4072-979f-2ef3464d1b71', CAST(N'2016-10-12 14:22:26.087' AS DateTime), N'<aboutPage id="1112" key="ad5cacc4-f152-440e-8455-a8dc5d0c3042" parentID="1075" level="2" creatorID="0" sortOrder="6" createDate="2016-10-10T11:30:01" updateDate="2016-10-12T14:22:26" nodeName="About" urlName="about" path="-1,1075,1112" isDoc="" nodeType="1110" creatorName="elias" writerName="elias" writerID="0" template="1109" nodeTypeAlias="aboutPage"><UmbracoNaviHide>0</UmbracoNaviHide><aboutGrid><![CDATA[{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90"
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>somehtin somethign about vision</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ]
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>something something somethign</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Something something about the skills</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ]
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "active": true
        }
      ]
    }
  ]
}]]></aboutGrid></aboutPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1112, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', CAST(N'2016-10-10 11:30:01.977' AS DateTime), N'<aboutPage id="1112" key="ad5cacc4-f152-440e-8455-a8dc5d0c3042" parentID="1075" level="2" creatorID="0" sortOrder="6" createDate="2016-10-10T11:30:01" updateDate="2016-10-10T11:30:01" nodeName="About" urlName="about" path="-1,1075,1112" isDoc="" nodeType="1110" creatorName="elias" writerName="elias" writerID="0" template="1109" nodeTypeAlias="aboutPage"><UmbracoNaviHide>0</UmbracoNaviHide><aboutGrid><![CDATA[{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "a7d068d0-e029-883c-bbc0-f40fd58d6b73",
          "active": false
        }
      ]
    }
  ]
}]]></aboutGrid></aboutPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1112, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', CAST(N'2016-10-11 21:48:49.380' AS DateTime), N'<aboutPage id="1112" key="ad5cacc4-f152-440e-8455-a8dc5d0c3042" parentID="1075" level="2" creatorID="0" sortOrder="6" createDate="2016-10-10T11:30:01" updateDate="2016-10-11T21:48:49" nodeName="About" urlName="about" path="-1,1075,1112" isDoc="" nodeType="1110" creatorName="elias" writerName="elias" writerID="0" template="1109" nodeTypeAlias="aboutPage"><UmbracoNaviHide>0</UmbracoNaviHide><aboutGrid><![CDATA[{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            }
          ],
          "hasConfig": false,
          "id": "a7d068d0-e029-883c-bbc0-f40fd58d6b73"
        }
      ]
    }
  ]
}]]></aboutGrid></aboutPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1112, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', CAST(N'2016-10-12 14:28:02.093' AS DateTime), N'<aboutPage id="1112" key="ad5cacc4-f152-440e-8455-a8dc5d0c3042" parentID="1075" level="2" creatorID="0" sortOrder="6" createDate="2016-10-10T11:30:01" updateDate="2016-10-12T14:28:02" nodeName="About" urlName="about" path="-1,1075,1112" isDoc="" nodeType="1110" creatorName="elias" writerName="elias" writerID="0" template="1109" nodeTypeAlias="aboutPage"><UmbracoNaviHide>0</UmbracoNaviHide><aboutGrid><![CDATA[{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>This site is focusing on the new technologies in the development world, we strive to educate people and give people the chance to become a part of a larger society and explore the new things that are sterring in the programming world.</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90",
          "active": false
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>Our vission is to assemble a creat team of programmers to share projects and experience and together widen our collective horison to become better at our jobs, and create the future in programming</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>We seek people who are passionate about programming and strives to learn new things but also share their experince with others.</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Your skills to join this awesome team could be anything from Android to PHP we want a wide net of programmers to share as much knowledge as possible</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": true
                }
              ],
              "active": true,
              "hasActiveChild": true
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "hasActiveChild": true,
          "active": true
        }
      ]
    }
  ]
}]]></aboutGrid></aboutPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1112, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', CAST(N'2016-10-12 14:22:21.753' AS DateTime), N'<aboutPage id="1112" key="ad5cacc4-f152-440e-8455-a8dc5d0c3042" parentID="1075" level="2" creatorID="0" sortOrder="6" createDate="2016-10-10T11:30:01" updateDate="2016-10-12T14:22:21" nodeName="About" urlName="about" path="-1,1075,1112" isDoc="" nodeType="1110" creatorName="elias" writerName="elias" writerID="0" template="1109" nodeTypeAlias="aboutPage"><UmbracoNaviHide>0</UmbracoNaviHide><aboutGrid><![CDATA[{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90",
          "active": false
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>somehtin somethign about vision</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>something something somethign</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Something something about the skills</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "active": true
        }
      ]
    }
  ]
}]]></aboutGrid></aboutPage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1119, N'10351876-5e24-473a-940c-afe9f0b7af17', CAST(N'2016-10-11 21:49:09.050' AS DateTime), N'<articleMain id="1119" key="f2ff3436-9469-4ba6-8fd3-6aa396e29f08" parentID="1075" level="2" creatorID="0" sortOrder="7" createDate="2016-10-11T20:14:05" updateDate="2016-10-11T21:49:09" nodeName="Articles" urlName="articles" path="-1,1075,1119" isDoc="" nodeType="1052" creatorName="elias" writerName="elias" writerID="0" template="1104" nodeTypeAlias="articleMain"><UmbracoNaviHide>0</UmbracoNaviHide><articlesHeader><![CDATA[Articles for your learning pleasure]]></articlesHeader><articlesText><![CDATA[<p>Here you can read up on new exiting things that happens in the programming world, and read about some of the projects which is going on.</p>]]></articlesText></articleMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', CAST(N'2016-10-11 20:14:05.647' AS DateTime), N'<articleMain id="1119" key="f2ff3436-9469-4ba6-8fd3-6aa396e29f08" parentID="1075" level="2" creatorID="0" sortOrder="7" createDate="2016-10-11T20:14:05" updateDate="2016-10-11T20:14:05" nodeName="Articles" urlName="articles" path="-1,1075,1119" isDoc="" nodeType="1052" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="articleMain"><UmbracoNaviHide>0</UmbracoNaviHide><articlesHeader><![CDATA[Articles for your learning pleasure]]></articlesHeader><articlesText><![CDATA[<p>Here you can read up on new exiting things that happens in the programming world, and read about some of the projects which is going on.</p>]]></articlesText></articleMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', CAST(N'2016-10-12 04:00:31.403' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-12T04:00:31" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1102" nodeTypeAlias="projectMain"><UmbracoNaviHide>1</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', CAST(N'2016-10-12 14:39:12.320' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-12T14:39:12" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1102" nodeTypeAlias="projectMain"><UmbracoNaviHide>0</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', CAST(N'2016-10-11 21:49:21.640' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-11T21:49:21" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1102" nodeTypeAlias="projectMain"><UmbracoNaviHide>0</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', CAST(N'2016-10-11 20:15:47.077' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-11T20:15:47" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="projectMain"><UmbracoNaviHide>0</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', CAST(N'2016-10-12 04:01:34.933' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-12T04:01:34" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1102" nodeTypeAlias="projectMain"><UmbracoNaviHide>1</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', CAST(N'2016-10-12 04:01:03.120' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-12T04:01:03" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="1102" nodeTypeAlias="projectMain"><UmbracoNaviHide>0</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader><projectsDescription><![CDATA[<p>See what type of projects that are going on in the Århus web develpåment group.</p>]]></projectsDescription></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', CAST(N'2016-10-11 20:15:05.633' AS DateTime), N'<projectMain id="1120" key="f8f06a98-7e88-4615-bee4-369072d98d20" parentID="1075" level="2" creatorID="0" sortOrder="8" createDate="2016-10-11T20:15:05" updateDate="2016-10-11T20:15:05" nodeName="Projects" urlName="projects" path="-1,1075,1120" isDoc="" nodeType="1067" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="projectMain"><UmbracoNaviHide>0</UmbracoNaviHide><projectsHeader><![CDATA[Projects to join and seak inspiration]]></projectsHeader></projectMain>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', CAST(N'2016-10-12 12:23:02.497' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:23:02" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview><articlePicture><![CDATA[{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png",
  "crops": [
    {
      "alias": "article",
      "width": 400,
      "height": 300,
      "coordinates": {
        "x1": 0.036078431372549027,
        "y1": 3.7895612573872022E-16,
        "x2": 0.24235294117647041,
        "y2": 0
      }
    }
  ]
}]]></articlePicture></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', CAST(N'2016-10-12 12:14:48.423' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:14:48" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview><articlePicture><![CDATA[{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png"
}]]></articlePicture></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', CAST(N'2016-10-12 12:26:32.707' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:26:32" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview><articlePicture><![CDATA[{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png",
  "crops": [
    {
      "alias": "article",
      "width": 600,
      "height": 300,
      "coordinates": {
        "x1": 0.03529411764705883,
        "y1": 0,
        "x2": 0.24313725490196073,
        "y2": 0.3333333333333332
      }
    },
    {
      "alias": "normal",
      "width": 400,
      "height": 700,
      "coordinates": {
        "x1": 0.020261951798578533,
        "y1": 0,
        "x2": 0.71922723936255462,
        "y2": 0.15758733011344669
      }
    }
  ]
}]]></articlePicture></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', CAST(N'2016-10-11 21:48:57.670' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-11T21:48:57" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>somehting about Angular 2</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', CAST(N'2016-10-12 12:10:52.970' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:10:52" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview><articlePicture><![CDATA[{
  "focalPoint": {
    "left": 0.5,
    "top": 0.5
  },
  "src": "/media/1002/angular-2-features.png"
}]]></articlePicture></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', CAST(N'2016-10-11 20:16:21.570' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-11T20:16:21" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>somehting about Angular 2</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', CAST(N'2016-10-12 12:10:27.497' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:10:27" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', CAST(N'2016-10-12 12:31:02.413' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:31:02" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p><img src="/media/1001/angular-2-features.png?width=500&amp;height=270.5882352941177" alt="" rel="1127" data-id="1127" /></p>
<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', CAST(N'2016-10-12 12:05:55.470' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:05:55" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', CAST(N'2016-10-12 12:23:49.730' AS DateTime), N'<articleItem id="1121" key="5a15946a-5541-44f1-a66b-1721565e50f8" parentID="1119" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:16:21" updateDate="2016-10-12T12:23:49" nodeName="Angular 2" urlName="angular-2" path="-1,1075,1119,1121" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[Angular 2 the new thing?]]></articleHeader><articleMainText><![CDATA[<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>]]></articleMainText><preview><![CDATA[Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]]]></preview><articlePicture><![CDATA[{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png",
  "crops": [
    {
      "alias": "article",
      "width": 600,
      "height": 300,
      "coordinates": {
        "x1": 0.03529411764705883,
        "y1": 0,
        "x2": 0.24313725490196073,
        "y2": 0.3333333333333332
      }
    }
  ]
}]]></articlePicture></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', CAST(N'2016-10-11 21:49:03.580' AS DateTime), N'<articleItem id="1122" key="12f925b4-4fdb-4b5d-9f6d-5a576cad4ef2" parentID="1119" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:16:51" updateDate="2016-10-11T21:49:03" nodeName="NodeJS" urlName="nodejs" path="-1,1075,1119,1122" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="1105" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[NodeJS - The future?]]></articleHeader><articleMainText><![CDATA[<p>Is this the future</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', CAST(N'2016-10-11 20:16:52.007' AS DateTime), N'<articleItem id="1122" key="12f925b4-4fdb-4b5d-9f6d-5a576cad4ef2" parentID="1119" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:16:51" updateDate="2016-10-11T20:16:51" nodeName="NodeJS" urlName="nodejs" path="-1,1075,1119,1122" isDoc="" nodeType="1055" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="articleItem"><UmbracoNaviHide>0</UmbracoNaviHide><articleHeader><![CDATA[NodeJS - The future?]]></articleHeader><articleMainText><![CDATA[<p>Is this the future</p>]]></articleMainText></articleItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', CAST(N'2016-10-11 20:17:32.327' AS DateTime), N'<projectsItem id="1123" key="30f52ed6-fac9-4e15-aec4-14eae99e7635" parentID="1120" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:17:32" updateDate="2016-10-11T20:17:32" nodeName="Umbraco mandatory" urlName="umbraco-mandatory" path="-1,1075,1120,1123" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectHeader><![CDATA[WebDev Coop Århus]]></projectHeader><projectText><![CDATA[<p>This site is now live and you can check out the project below</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', CAST(N'2016-10-13 16:06:46.577' AS DateTime), N'<projectsItem id="1123" key="30f52ed6-fac9-4e15-aec4-14eae99e7635" parentID="1120" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:17:32" updateDate="2016-10-13T16:06:46" nodeName="Umbraco mandatory" urlName="umbraco-mandatory" path="-1,1075,1120,1123" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><preview><![CDATA[This project is a small fun project to show of what umbraco can be used for.]]></preview><projectHeader><![CDATA[WebDev Coop Århus]]></projectHeader><projectText><![CDATA[<p>This site is now live and you can check out the project below</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', CAST(N'2016-10-13 16:05:15.773' AS DateTime), N'<projectsItem id="1123" key="30f52ed6-fac9-4e15-aec4-14eae99e7635" parentID="1120" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:17:32" updateDate="2016-10-13T16:05:15" nodeName="Umbraco mandatory" urlName="umbraco-mandatory" path="-1,1075,1120,1123" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><preview><![CDATA[This project is a small fun project to show of what umbraco can be used for.]]></preview><projectHeader><![CDATA[WebDev Coop Århus]]></projectHeader><projectText><![CDATA[<p>This site is now live and you can check out the project below</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', CAST(N'2016-10-12 03:30:55.653' AS DateTime), N'<projectsItem id="1123" key="30f52ed6-fac9-4e15-aec4-14eae99e7635" parentID="1120" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:17:32" updateDate="2016-10-12T03:30:55" nodeName="Umbraco mandatory" urlName="umbraco-mandatory" path="-1,1075,1120,1123" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><projectHeader><![CDATA[WebDev Coop Århus]]></projectHeader><projectText><![CDATA[<p>This site is now live and you can check out the project below</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', CAST(N'2016-10-11 20:17:45.363' AS DateTime), N'<projectsItem id="1123" key="30f52ed6-fac9-4e15-aec4-14eae99e7635" parentID="1120" level="3" creatorID="0" sortOrder="0" createDate="2016-10-11T20:17:32" updateDate="2016-10-11T20:17:45" nodeName="Umbraco mandatory" urlName="umbraco-mandatory" path="-1,1075,1120,1123" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><projectHeader><![CDATA[WebDev Coop Århus]]></projectHeader><projectText><![CDATA[<p>This site is now live and you can check out the project below</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', CAST(N'2016-10-13 16:06:01.513' AS DateTime), N'<projectsItem id="1124" key="7f9f0597-32b7-438b-8ceb-41d57d77b1bf" parentID="1120" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:18:26" updateDate="2016-10-13T16:06:01" nodeName="Android shoppinglist" urlName="android-shoppinglist" path="-1,1075,1120,1124" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Under Development]]></projectStatus><preview><![CDATA[Android shoppinglist with hookup to firebase for a more comfortable experience]]></preview><projectHeader><![CDATA[A shoppinglist for Android]]></projectHeader><projectText><![CDATA[<p>Check out the code below and make your own changes</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', CAST(N'2016-10-11 21:49:35.930' AS DateTime), N'<projectsItem id="1124" key="7f9f0597-32b7-438b-8ceb-41d57d77b1bf" parentID="1120" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:18:26" updateDate="2016-10-11T21:49:35" nodeName="Android shoppinglist" urlName="android-shoppinglist" path="-1,1075,1120,1124" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Under Development]]></projectStatus><projectHeader><![CDATA[A shoppinglist for Android]]></projectHeader><projectText><![CDATA[<p>Check out the code below and make your own changes</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', CAST(N'2016-10-11 20:18:26.363' AS DateTime), N'<projectsItem id="1124" key="7f9f0597-32b7-438b-8ceb-41d57d77b1bf" parentID="1120" level="3" creatorID="0" sortOrder="1" createDate="2016-10-11T20:18:26" updateDate="2016-10-11T20:18:26" nodeName="Android shoppinglist" urlName="android-shoppinglist" path="-1,1075,1120,1124" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Under Development]]></projectStatus><projectHeader><![CDATA[A shoppinglist for Android]]></projectHeader><projectText><![CDATA[<p>Check out the code below and make your own changes</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1130, N'aad9bf99-da5c-45c2-834d-6163a51d007b', CAST(N'2016-10-12 16:40:13.107' AS DateTime), N'<boardMessages id="1130" key="6482b22f-f290-4a03-8c16-11156c7b7327" parentID="1075" level="2" creatorID="0" sortOrder="9" createDate="2016-10-12T16:40:13" updateDate="2016-10-12T16:40:13" nodeName="Messageboard" urlName="messageboard" path="-1,1075,1130" isDoc="" nodeType="1126" creatorName="elias" writerName="elias" writerID="0" template="1125" nodeTypeAlias="boardMessages"><UmbracoNaviHide>0</UmbracoNaviHide><title><![CDATA[Keep yourself updated!]]></title></boardMessages>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1131, N'cbe2c390-9d41-425f-819e-58bab291c22e', CAST(N'2016-10-12 16:41:32.013' AS DateTime), N'<boardMessage id="1131" key="b2a4ffd1-f0d4-4f7f-b3bc-80b5355ab909" parentID="1130" level="3" creatorID="0" sortOrder="0" createDate="2016-10-12T16:41:31" updateDate="2016-10-12T16:41:31" nodeName="Angular" urlName="angular" path="-1,1075,1130,1131" isDoc="" nodeType="1118" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="boardMessage"><message><![CDATA[Learn about Angular 2 it''s going to be the new things]]></message><date>2016-10-12T16:40:25</date><title><![CDATA[Angular 2 is out]]></title><publisher><![CDATA[Elias]]></publisher></boardMessage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1133, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', CAST(N'2016-10-13 13:14:40.867' AS DateTime), N'<boardMessages id="1133" key="b30049d5-eb25-4c2a-9b37-1836c658421f" parentID="1075" level="2" creatorID="0" sortOrder="9" createDate="2016-10-13T13:14:40" updateDate="2016-10-13T13:14:40" nodeName="MessageBoard" urlName="messageboard" path="-1,1075,1133" isDoc="" nodeType="1126" creatorName="elias" writerName="elias" writerID="0" template="0" nodeTypeAlias="boardMessages"><UmbracoNaviHide>0</UmbracoNaviHide><title><![CDATA[Keep yourself updated!]]></title></boardMessages>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1133, N'67207c55-b02c-4338-9828-b8c365a07696', CAST(N'2016-10-13 13:15:48.503' AS DateTime), N'<boardMessages id="1133" key="b30049d5-eb25-4c2a-9b37-1836c658421f" parentID="1075" level="2" creatorID="0" sortOrder="9" createDate="2016-10-13T13:14:40" updateDate="2016-10-13T13:15:48" nodeName="MessageBoard" urlName="messageboard" path="-1,1075,1133" isDoc="" nodeType="1126" creatorName="elias" writerName="elias" writerID="0" template="1132" nodeTypeAlias="boardMessages"><UmbracoNaviHide>0</UmbracoNaviHide><title><![CDATA[Keep yourself updated!]]></title></boardMessages>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1134, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', CAST(N'2016-10-13 15:22:51.157' AS DateTime), N'<boardMessage id="1134" key="d01aabaa-b578-4325-8105-3d2cf309017d" parentID="1133" level="3" creatorID="0" sortOrder="0" createDate="2016-10-13T15:22:51" updateDate="2016-10-13T15:22:51" nodeName="Angular is back" urlName="angular-is-back" path="-1,1075,1133,1134" isDoc="" nodeType="1118" creatorName="elias" writerName="elias" writerID="0" template="1132" nodeTypeAlias="boardMessage"><content><![CDATA[something something]]></content><date>2016-10-13T15:22:51.0855378</date><title><![CDATA[Angular is back]]></title><publisher><![CDATA[daniel]]></publisher></boardMessage>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', CAST(N'2016-10-13 16:29:34.110' AS DateTime), N'<projectsItem id="1135" key="0eae9b80-5d00-45d3-b93b-9dc46b6a7feb" parentID="1120" level="3" creatorID="0" sortOrder="2" createDate="2016-10-13T16:29:34" updateDate="2016-10-13T16:29:34" nodeName="M.E.A.N Stack solution" urlName="mean-stack-solution" path="-1,1075,1120,1135" isDoc="" nodeType="1071" creatorName="elias" writerName="elias" writerID="0" template="1103" nodeTypeAlias="projectsItem"><UmbracoNaviHide>0</UmbracoNaviHide><projectStatus><![CDATA[Completed]]></projectStatus><preview><![CDATA[Mongo, Express, Angular, NodeJS]]></preview><projectHeader><![CDATA[The MEAN stack]]></projectHeader><projectText><![CDATA[<p>Learn about mean stacks and what they have to offer</p>]]></projectText></projectsItem>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1141, N'e20de96c-7af4-42ce-84cb-85c1a4980a50', CAST(N'2016-10-13 17:39:39.803' AS DateTime), N'<memberView id="1141" key="79a1196e-b387-4317-b74f-b9e55d440f6e" parentID="1075" level="2" creatorID="0" sortOrder="10" createDate="2016-10-13T17:39:39" updateDate="2016-10-13T17:39:39" nodeName="Members" urlName="members" path="-1,1075,1141" isDoc="" nodeType="1139" creatorName="elias" writerName="elias" writerID="0" template="1140" nodeTypeAlias="memberView"><UmbracoNaviHide>0</UmbracoNaviHide></memberView>')
SET IDENTITY_INSERT [dbo].[cmsPropertyData] ON 

INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (2, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (3, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', 46, NULL, NULL, NULL, NULL, N'unending contact thing')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (4, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', 38, NULL, NULL, NULL, NULL, N'<p>Welcome to Århus WebDevCoop this is wierd</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (5, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', 47, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (6, 1075, N'ff44be02-79d9-4056-a867-bc97af070b3c', 37, NULL, NULL, NULL, N'WebDev community', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (7, 1076, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (8, 1076, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (9, 1076, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', 39, NULL, NULL, NULL, N'Articles', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (10, 1076, N'b638c890-aac5-4b0a-8f27-722ce27dfcd7', 40, NULL, NULL, NULL, NULL, N'<p>Here are some exiting articles for you to read about</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (11, 1077, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (12, 1077, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (13, 1077, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', 48, NULL, NULL, NULL, N'Projects', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (14, 1077, N'9ef9ded4-01ab-4c7e-bd9a-317caa004207', 49, NULL, NULL, NULL, NULL, N'<p>here are some projects that are ongoing on this site, feel free to look at them and contact the developers with ideas</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (15, 1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (16, 1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (17, 1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', 41, NULL, NULL, NULL, N'Mongo DB', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (18, 1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', 42, NULL, NULL, NULL, NULL, N'<p>Mongo is fast and awesome... HURRAYYY</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (19, 1078, N'b6309d03-0d98-4814-b461-fa4b867c6477', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (20, 1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (21, 1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (22, 1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', 41, NULL, NULL, NULL, N'Socket Io', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (23, 1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', 42, NULL, NULL, NULL, NULL, N'<p>socket IO is good but we do not learn enough about it</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (24, 1079, N'4e46d491-c3e9-4cd7-ba88-04944d96d36d', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (25, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (26, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (27, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (28, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (29, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (30, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 50, NULL, NULL, NULL, N'Chat with Socket IO', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (31, 1080, N'b34658a3-bea1-4e0a-9ac6-9db86ad6f242', 51, NULL, NULL, NULL, NULL, N'<p>Here are some chat application with socket IO remember to install the npm package</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (32, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (33, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (34, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (35, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 54, NULL, NULL, NULL, N'12', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (36, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (37, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 50, NULL, NULL, NULL, N'Umbraco with MVC', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (38, 1081, N'171ef749-85d4-4109-a0f7-1148237d7678', 51, NULL, NULL, NULL, NULL, N'<p>This is how ambraco and MVC can wrk together. good luck</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (39, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 64, NULL, NULL, NULL, N'Daniel', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (40, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 65, NULL, NULL, NULL, N'Adler', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (41, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 66, NULL, NULL, NULL, N'54784512', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (42, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 67, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (43, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 68, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (44, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 69, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (45, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 70, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (46, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 71, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (47, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 72, NULL, NULL, CAST(N'2016-10-13 17:40:05.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (48, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 73, NULL, NULL, CAST(N'2016-10-13 13:33:50.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (49, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 74, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (50, 1088, N'19e0b822-cba8-4723-ba2b-7fce103c4b04', 75, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (51, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 55, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (52, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 56, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (53, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 28, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (54, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 29, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (55, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 30, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (56, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 31, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (57, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 32, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (58, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 33, NULL, NULL, CAST(N'2016-09-26 09:38:17.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (59, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 34, NULL, NULL, CAST(N'2016-09-26 09:38:17.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (60, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 57, NULL, NULL, NULL, N'Elias', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (61, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 58, NULL, NULL, NULL, N'Hansen', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (62, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 59, NULL, NULL, NULL, N'Søndre ringgade 63', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (63, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 60, NULL, NULL, NULL, N'8000', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (64, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 61, NULL, NULL, NULL, N'Århus C', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (65, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 62, NULL, NULL, NULL, N'50988305', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (66, 1089, N'5f299e00-8920-4aca-a99f-202a8ef07922', 63, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.5,
    "top": 0.5
  },
  "src": "/media/1003/person2.jpg",
  "crops": [
    {
      "alias": "normal",
      "width": 400,
      "height": 700
    },
    {
      "alias": "article",
      "width": 700,
      "height": 500
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (67, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 55, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (68, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 56, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (69, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 28, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (70, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 29, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (71, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 30, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (72, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 31, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (73, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 32, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (74, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 33, NULL, NULL, CAST(N'2016-09-26 09:40:52.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (75, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 34, NULL, NULL, CAST(N'2016-09-26 09:40:52.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (76, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 57, NULL, NULL, NULL, N'Christian', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (77, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 58, NULL, NULL, NULL, N'Barlach', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (78, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 59, NULL, NULL, NULL, N'somewhere', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (79, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 60, NULL, NULL, NULL, N'0000', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (80, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 61, NULL, NULL, NULL, N'elsewhere', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (81, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 62, NULL, NULL, NULL, N'666333', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (82, 1090, N'4bdc0588-5443-48e1-89c3-2930516a802c', 63, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.5,
    "top": 0.5
  },
  "src": "/media/1004/person.jpg",
  "crops": [
    {
      "alias": "normal",
      "width": 400,
      "height": 700
    },
    {
      "alias": "article",
      "width": 700,
      "height": 500
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (83, 1092, N'62209e30-c43f-4767-818d-5c6d553d25fa', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (84, 1092, N'62209e30-c43f-4767-818d-5c6d553d25fa', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (85, 1092, N'62209e30-c43f-4767-818d-5c6d553d25fa', 45, NULL, NULL, NULL, NULL, N'<p>Login to our website to get the full experience</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (86, 1092, N'62209e30-c43f-4767-818d-5c6d553d25fa', 44, NULL, NULL, NULL, N'Login Page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (87, 1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (88, 1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (89, 1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', 41, NULL, NULL, NULL, N'M.E.A.N Stack', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (90, 1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', 42, NULL, NULL, NULL, NULL, N'<p>The MEAN stack is awesome</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (91, 1093, N'63eea632-36a1-4d24-8124-1930a0d3f0ec', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (92, 1094, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (93, 1094, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (94, 1094, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', 45, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (95, 1094, N'eb45da88-8b7f-4eca-b0fd-f91f2f8ffea6', 44, NULL, NULL, NULL, N'You are not allowed on the page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (96, 1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (97, 1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (98, 1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (99, 1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', 45, NULL, NULL, NULL, NULL, N'')
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (100, 1094, N'4ebafe69-133b-4457-91ef-8a9511a94fd6', 44, NULL, NULL, NULL, N'You are not allowed on the page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (104, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (105, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (106, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (107, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 46, NULL, NULL, NULL, NULL, N'unending contact thing')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (108, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 38, NULL, NULL, NULL, NULL, N'<p>Welcome to Århus WebDevCoop this is wierd</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (109, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 47, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (110, 1075, N'4cff21d5-43be-47de-967e-e2de667ff4b6', 37, NULL, NULL, NULL, N'WebDev community', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (111, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (112, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (113, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (114, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (115, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (116, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (117, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 50, NULL, NULL, NULL, N'Chat with Socket IO', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (118, 1080, N'782206b6-d271-4e94-ad5f-0c861234ceca', 51, NULL, NULL, NULL, NULL, N'<p>Here are some chat application with socket IO remember to install the npm package</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (119, 1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (120, 1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (121, 1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (122, 1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', 45, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (123, 1108, N'ab3cbf9e-f2ab-4e63-a78f-3a1c2ef4cc83', 44, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (128, 1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (129, 1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (130, 1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (131, 1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', 45, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (132, 1108, N'cd0ffa31-3045-416b-8bb0-e10e128ee8cf', 44, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (133, 1112, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (134, 1112, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (135, 1112, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (136, 1112, N'2540cf6a-a4be-4c12-b537-865fa6c3147b', 78, NULL, NULL, NULL, NULL, N'{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "a7d068d0-e029-883c-bbc0-f40fd58d6b73",
          "active": false
        }
      ]
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (137, 1076, N'd61239b7-9426-4b8d-b880-364f822f0974', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (138, 1076, N'd61239b7-9426-4b8d-b880-364f822f0974', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (139, 1076, N'd61239b7-9426-4b8d-b880-364f822f0974', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (140, 1076, N'd61239b7-9426-4b8d-b880-364f822f0974', 39, NULL, NULL, NULL, N'Articles', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (141, 1076, N'd61239b7-9426-4b8d-b880-364f822f0974', 40, NULL, NULL, NULL, NULL, N'<p>Here are some exiting articles for you to read about</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (142, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (143, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (144, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (145, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', 41, NULL, NULL, NULL, N'M.E.A.N Stack', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (146, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', 42, NULL, NULL, NULL, NULL, N'<p>The MEAN stack is awesome</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (147, 1093, N'a13de735-8528-4377-b37a-95fb684c278e', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (148, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (149, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (150, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (151, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', 41, NULL, NULL, NULL, N'Socket Io', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (152, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', 42, NULL, NULL, NULL, NULL, N'<p>socket IO is good but we do not learn enough about it</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (153, 1079, N'452ea599-c859-476a-b38a-26772fbdbbd1', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (154, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (155, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (156, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (157, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', 41, NULL, NULL, NULL, N'Mongo DB', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (158, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', 42, NULL, NULL, NULL, NULL, N'<p>Mongo is fast and awesome... HURRAYYY</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (159, 1078, N'ee29bf5a-1294-4d4b-954c-a56ebdebf9c2', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (160, 1076, N'e7929ac3-bebc-4801-8788-d249c4fdf418', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (161, 1076, N'e7929ac3-bebc-4801-8788-d249c4fdf418', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (162, 1076, N'e7929ac3-bebc-4801-8788-d249c4fdf418', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (163, 1076, N'e7929ac3-bebc-4801-8788-d249c4fdf418', 39, NULL, NULL, NULL, N'Articles', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (164, 1076, N'e7929ac3-bebc-4801-8788-d249c4fdf418', 40, NULL, NULL, NULL, NULL, N'<p>Here are some exiting articles for you to read about</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (165, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (166, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (167, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (168, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', 41, NULL, NULL, NULL, N'M.E.A.N Stack', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (169, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', 42, NULL, NULL, NULL, NULL, N'<p>The MEAN stack is awesome</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (170, 1093, N'e1d5b1f4-4098-41de-91f9-0c476390ecc4', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (171, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (172, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (173, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (174, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', 41, NULL, NULL, NULL, N'Socket Io', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (175, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', 42, NULL, NULL, NULL, NULL, N'<p>socket IO is good but we do not learn enough about it</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (176, 1079, N'c7e62b4e-6632-4991-bd6b-b16a7667d20f', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (177, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (178, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (179, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (180, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', 41, NULL, NULL, NULL, N'Mongo DB', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (181, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', 42, NULL, NULL, NULL, NULL, N'<p>Mongo is fast and awesome... HURRAYYY</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (182, 1078, N'08b1a32b-c8fe-4d68-8c3d-33f9b904eb72', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (183, 1077, N'ff5c19c1-988a-4462-97cb-36949b2aa670', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (184, 1077, N'ff5c19c1-988a-4462-97cb-36949b2aa670', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (185, 1077, N'ff5c19c1-988a-4462-97cb-36949b2aa670', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (186, 1077, N'ff5c19c1-988a-4462-97cb-36949b2aa670', 48, NULL, NULL, NULL, N'Projects', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (187, 1077, N'ff5c19c1-988a-4462-97cb-36949b2aa670', 49, NULL, NULL, NULL, NULL, N'<p>here are some projects that are ongoing on this site, feel free to look at them and contact the developers with ideas</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (188, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (189, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (190, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (191, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 52, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (192, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (193, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (194, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 50, NULL, NULL, NULL, N'Chat with Socket IO', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (195, 1080, N'c02dc26a-9897-41f6-a146-f1e5234a5e74', 51, NULL, NULL, NULL, NULL, N'<p>Here are some chat application with socket IO remember to install the npm package</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (196, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (197, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (198, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (199, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 52, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (200, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 54, NULL, NULL, NULL, N'12', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (201, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (202, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 50, NULL, NULL, NULL, N'Umbraco with MVC', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (203, 1081, N'be293588-dc49-4f09-afb8-c1bb2393a8ba', 51, NULL, NULL, NULL, NULL, N'<p>This is how ambraco and MVC can wrk together. good luck</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (204, 1077, N'0168e231-864a-4863-862c-cf8541ff5a61', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (205, 1077, N'0168e231-864a-4863-862c-cf8541ff5a61', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (206, 1077, N'0168e231-864a-4863-862c-cf8541ff5a61', 76, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (207, 1077, N'0168e231-864a-4863-862c-cf8541ff5a61', 48, NULL, NULL, NULL, N'Projects', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (208, 1077, N'0168e231-864a-4863-862c-cf8541ff5a61', 49, NULL, NULL, NULL, NULL, N'<p>here are some projects that are ongoing on this site, feel free to look at them and contact the developers with ideas</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (209, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (210, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (211, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (212, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 52, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (213, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (214, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (215, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 50, NULL, NULL, NULL, N'Chat with Socket IO', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (216, 1080, N'5bb0c8f3-f454-4795-bb04-93d501a5442d', 51, NULL, NULL, NULL, NULL, N'<p>Here are some chat application with socket IO remember to install the npm package</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (217, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (218, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (219, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (220, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 52, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (221, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 54, NULL, NULL, NULL, N'12', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (222, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (223, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 50, NULL, NULL, NULL, N'Umbraco with MVC', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (224, 1081, N'b4e15a3f-fd08-4843-841e-7429aff8a51d', 51, NULL, NULL, NULL, NULL, N'<p>This is how ambraco and MVC can wrk together. good luck</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (225, 1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (226, 1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (227, 1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (228, 1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', 39, NULL, NULL, NULL, N'Articles for your learning pleasure', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (229, 1119, N'd3a2bcec-2b22-471e-b47e-ce87de67c3d5', 40, NULL, NULL, NULL, NULL, N'<p>Here you can read up on new exiting things that happens in the programming world, and read about some of the projects which is going on.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (230, 1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (231, 1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (232, 1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (233, 1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (234, 1120, N'326ac56c-6f4c-4d86-a981-fbd65314dbb5', 49, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (235, 1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (236, 1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (237, 1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (238, 1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (239, 1120, N'fffffb12-0a91-4ba3-816f-dbbca8cc6fdb', 49, NULL, NULL, NULL, NULL, N'<p>See what type of projects that are going on in the Århus web develpåment group.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (240, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (241, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (242, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (243, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (244, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', 42, NULL, NULL, NULL, NULL, N'<p>somehting about Angular 2</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (245, 1121, N'2b1cea47-5235-42f9-91d8-9da5d5fbe914', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (246, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (247, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (248, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (249, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', 41, NULL, NULL, NULL, N'NodeJS - The future?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (250, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', 42, NULL, NULL, NULL, NULL, N'<p>Is this the future</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (251, 1122, N'835389c9-035f-439d-b849-8a1f7fa9b9bc', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (252, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (253, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (254, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (255, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (256, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 54, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (257, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (258, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 50, NULL, NULL, NULL, N'WebDev Coop Århus', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (259, 1123, N'7a6270a7-fd9a-4055-95da-11e943194a4c', 51, NULL, NULL, NULL, NULL, N'<p>This site is now live and you can check out the project below</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (260, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (261, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (262, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (263, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (264, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 54, NULL, NULL, NULL, N'15', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (265, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (266, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 50, NULL, NULL, NULL, N'WebDev Coop Århus', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (267, 1123, N'bc6ad06c-4d1c-4479-a094-9ec62f648c12', 51, NULL, NULL, NULL, NULL, N'<p>This site is now live and you can check out the project below</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (268, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (269, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (270, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (271, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (272, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (273, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (274, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 50, NULL, NULL, NULL, N'A shoppinglist for Android', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (275, 1124, N'bc5116ab-cc33-40e6-b2ee-da3868429cc4', 51, NULL, NULL, NULL, NULL, N'<p>Check out the code below and make your own changes</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (276, 1092, N'8d38e053-a525-4e65-b76d-6e1687109392', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (277, 1092, N'8d38e053-a525-4e65-b76d-6e1687109392', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (278, 1092, N'8d38e053-a525-4e65-b76d-6e1687109392', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (279, 1092, N'8d38e053-a525-4e65-b76d-6e1687109392', 45, NULL, NULL, NULL, NULL, N'<p>Login to our website to get the full experience</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (280, 1092, N'8d38e053-a525-4e65-b76d-6e1687109392', 44, NULL, NULL, NULL, N'Login Page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (281, 1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (282, 1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (283, 1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (284, 1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', 45, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (285, 1094, N'5b435f17-b61e-4ee6-a4c4-ba8e9601b117', 44, NULL, NULL, NULL, N'You are not allowed on the page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (286, 1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (287, 1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (288, 1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (289, 1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', 45, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (290, 1108, N'9655473d-fb0e-4e77-be3e-c67c0880f4e6', 44, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (291, 1112, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (292, 1112, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (293, 1112, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (294, 1112, N'ad1eceee-f26c-4c80-a5ac-86fa3bc58677', 78, NULL, NULL, NULL, NULL, N'{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            }
          ],
          "hasConfig": false,
          "id": "a7d068d0-e029-883c-bbc0-f40fd58d6b73"
        }
      ]
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (295, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (296, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (297, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (298, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (299, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', 42, NULL, NULL, NULL, NULL, N'<p>somehting about Angular 2</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (300, 1121, N'4f9141cf-9da6-4f57-ada5-61b7cf90c08b', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (301, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (302, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (303, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (304, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', 41, NULL, NULL, NULL, N'NodeJS - The future?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (305, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', 42, NULL, NULL, NULL, NULL, N'<p>Is this the future</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (306, 1122, N'5c054ca8-ee5b-483e-b153-6c8f49a68a4c', 43, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (307, 1119, N'10351876-5e24-473a-940c-afe9f0b7af17', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (308, 1119, N'10351876-5e24-473a-940c-afe9f0b7af17', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (309, 1119, N'10351876-5e24-473a-940c-afe9f0b7af17', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (310, 1119, N'10351876-5e24-473a-940c-afe9f0b7af17', 39, NULL, NULL, NULL, N'Articles for your learning pleasure', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (311, 1119, N'10351876-5e24-473a-940c-afe9f0b7af17', 40, NULL, NULL, NULL, NULL, N'<p>Here you can read up on new exiting things that happens in the programming world, and read about some of the projects which is going on.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (312, 1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (313, 1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (314, 1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (315, 1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (316, 1120, N'11c056da-bd0a-42a3-932c-80c77f58574f', 49, NULL, NULL, NULL, NULL, N'<p>See what type of projects that are going on in the Århus web develpåment group.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (317, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (318, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (319, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (320, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (321, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 54, NULL, NULL, NULL, N'15', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (322, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (323, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 50, NULL, NULL, NULL, N'WebDev Coop Århus', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (324, 1123, N'82ebe085-ef61-4592-929d-7bdf9c1a200c', 51, NULL, NULL, NULL, NULL, N'<p>This site is now live and you can check out the project below</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (325, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (326, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (327, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (328, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (329, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (330, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (331, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 50, NULL, NULL, NULL, N'A shoppinglist for Android', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (332, 1124, N'b55c4de1-2092-41ac-bf5d-d57d6c35b557', 51, NULL, NULL, NULL, NULL, N'<p>Check out the code below and make your own changes</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (333, 1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (334, 1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (335, 1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (336, 1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', 45, NULL, NULL, NULL, NULL, N'<p>Login to our website to get the full experience</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (337, 1092, N'5869c7f2-b682-4cf8-9b95-940297d10743', 44, NULL, NULL, NULL, N'Login Page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (338, 1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (339, 1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (340, 1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (341, 1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (342, 1120, N'94c3f814-78f5-4160-b2c9-0cce0b07b615', 49, NULL, NULL, NULL, NULL, N'<p>See what type of projects that are going on in the Århus web develpåment group.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (343, 1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (344, 1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (345, 1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (346, 1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (347, 1120, N'fcaaf67e-c36d-4dcf-88c8-e49e1a1e30d8', 49, NULL, NULL, NULL, NULL, N'<p>See what type of projects that are going on in the Århus web develpåment group.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (348, 1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (349, 1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (350, 1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (351, 1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (352, 1120, N'0d66a8a5-ed2c-4fe8-a1ad-de9ff5517a73', 49, NULL, NULL, NULL, NULL, N'<p>See what type of projects that are going on in the Århus web develpåment group.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (353, 1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (354, 1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (355, 1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (356, 1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', 45, NULL, NULL, NULL, NULL, N'<p>Login to our website to get the full experience</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (357, 1092, N'ae2e3c78-c5b1-4eac-904c-baaccd71fadc', 44, NULL, NULL, NULL, N'Login Page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (358, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (359, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (360, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (361, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (362, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (363, 1121, N'53e14690-bfc6-4ca3-b565-d5d573bf7819', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (364, 1127, N'443c67e8-1954-4583-858b-8cf7ffd0e612', 6, NULL, NULL, NULL, NULL, N'{src: ''/media/1001/angular-2-features.png'', crops: []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (365, 1127, N'443c67e8-1954-4583-858b-8cf7ffd0e612', 7, NULL, NULL, NULL, N'850', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (366, 1127, N'443c67e8-1954-4583-858b-8cf7ffd0e612', 8, NULL, NULL, NULL, N'460', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (367, 1127, N'443c67e8-1954-4583-858b-8cf7ffd0e612', 9, NULL, NULL, NULL, N'117648', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (368, 1127, N'443c67e8-1954-4583-858b-8cf7ffd0e612', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (369, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (370, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (371, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (372, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (373, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (374, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (375, 1121, N'10b19b23-5174-4bb6-960e-ad887191ee8a', 43, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (376, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (377, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (378, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (379, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (380, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (381, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (382, 1121, N'60df8ede-a0c4-4b95-a0be-792ec0ed7949', 43, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.5,
    "top": 0.5
  },
  "src": "/media/1002/angular-2-features.png"
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (383, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (384, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (385, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (386, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (387, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (388, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (389, 1121, N'e19c10e4-23a5-4924-895b-49015e351fc4', 43, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png"
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (390, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (391, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (392, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (393, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (394, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (395, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (396, 1121, N'9942909c-8931-48fb-ac6a-01ee074a3eeb', 43, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png",
  "crops": [
    {
      "alias": "article",
      "width": 400,
      "height": 300,
      "coordinates": {
        "x1": 0.036078431372549027,
        "y1": 3.7895612573872022E-16,
        "x2": 0.24235294117647041,
        "y2": 0
      }
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (397, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (398, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (399, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (400, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (401, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (402, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (403, 1121, N'b60686ad-bcd3-44c1-853f-e1cd58b3f5df', 43, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png",
  "crops": [
    {
      "alias": "article",
      "width": 600,
      "height": 300,
      "coordinates": {
        "x1": 0.03529411764705883,
        "y1": 0,
        "x2": 0.24313725490196073,
        "y2": 0.3333333333333332
      }
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (404, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (405, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (406, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 76, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (407, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (408, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 42, NULL, NULL, NULL, NULL, N'<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (409, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (410, 1121, N'e14c0cbc-ad28-49fa-879d-51f7ec501005', 43, NULL, NULL, NULL, NULL, N'{
  "focalPoint": {
    "left": 0.53166666666666662,
    "top": 0.46769230769230768
  },
  "src": "/media/1002/angular-2-features.png",
  "crops": [
    {
      "alias": "article",
      "width": 600,
      "height": 300,
      "coordinates": {
        "x1": 0.03529411764705883,
        "y1": 0,
        "x2": 0.24313725490196073,
        "y2": 0.3333333333333332
      }
    },
    {
      "alias": "normal",
      "width": 400,
      "height": 700,
      "coordinates": {
        "x1": 0.020261951798578533,
        "y1": 0,
        "x2": 0.71922723936255462,
        "y2": 0.15758733011344669
      }
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (411, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (412, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (413, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (414, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 41, NULL, NULL, NULL, N'Angular 2 the new thing?', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (415, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 42, NULL, NULL, NULL, NULL, N'<p><img src="/media/1001/angular-2-features.png?width=500&amp;height=270.5882352941177" alt="" rel="1127" data-id="1127" /></p>
<p>Two years ago Google <a href="http://www.infoworld.com/article/2610894/javascript/google-s-angularjs-2-promises-faster--slicker--future-proof-javascript.html">promised a major rewrite of AngularJS</a>, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally <a href="https://github.com/angular/angular/milestones/beta-00" target="_blank">nearing a beta release</a>.</p>
<p>Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.</p>
<p><strong>[ Need a JavaScript tool for your dev shop? InfoWorld looks at <a href="http://www.infoworld.com/resources/16306/javascript/hands-on-with-10-javascript-editors-and-ides#tk.ifw-infsb">17 JavaScript editors and IDEs</a> ready for adoption. | Keep up with hot topics in programming with InfoWorld''s <a href="http://www.infoworld.com/newsletters/signup.html#tk.ifw-infsb">Application Development newsletter</a>. ]</strong></p>
<h3>The rise of Web Components</h3>
<p>In AngularJS, nearly everything to control page rendering is done with <a href="https://docs.angularjs.org/guide/directive" target="_blank">directives</a>. There are lots of existing directives ranging from the very simple (for example, <a href="https://docs.angularjs.org/api/ng/directive/ngIf" target="_blank">ngIf</a>is a directive you can use to conditionally show/hide part of the page) to the complex (such as <a href="https://docs.angularjs.org/guide/databinding" target="_blank">data binding</a> with <a href="https://docs.angularjs.org/api/ng/directive/ngBind" target="_blank">ngBind</a>). You often create your own directives to add custom behavior to an element or simply to render a template.</p>
<p>Angular 2 largely replaces directives with “<a href="https://angular.io/docs/ts/latest/api/core/Component-var.html" target="_blank">components</a>.” This approach looks forward to future <a href="http://www.w3.org/standards/techs/components#w3c_all" target="_blank">Web Components specifications</a>, including <a href="http://www.w3.org/TR/shadow-dom/" target="_blank">Shadow DOM</a> and<a href="http://w3c.github.io/webcomponents/spec/imports/" target="_blank">HTML Imports</a>. Meanwhile, the component pattern is already showing up in many JavaScript libraries.</p>
<p>When you compare AngularJS’s directive approach with Angular 2''s component approach side by side, they appear very similar. But conceptually, they''re different:</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>angular.module(''App'', [])<br /> .directive(''example'', function() {<br />   return {<br />     template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br />   };<br /> });</td>
<td>var AppComponent = ng<br /> .Component({<br />   selector: ''my-app'',<br />   template: ''&lt;p&gt;Some DOM content&lt;/p&gt;''<br /> })<br /> .Class({<br />   constructor: function () { }<br /> });</td>
</tr>
</tbody>
</table>
<p>As a standard, <a href="https://hacks.mozilla.org/2015/06/the-state-of-web-components/" target="_blank">Web Components have some issues</a>. Browser vendors still need to shake things out a bit for Web Components to be implemented. As an architectural component of an client-side application, however, the Web Components approach is something to be reckoned with.</p>
<p>Componentization within the interface allows behavior and presentation to be modularized, testable, and reusable. Furthermore, the developers of Angular 2 plan to make it compatible with Web Components created with such libraries as Polymer and X-tag so that Angular 2 will be very friendly to code reuse.</p>
<p>The bottom line is that, once the kinks are ironed out, you''ll want to use Web Components. As it turns out, using a performant framework -- as Angular 2 intends to be -- may be one of the best ways to incorporate Web Components into your applications, while letting the framework authors and the community manage compatibility with evolving standards.</p>
<h3>Reactive programming</h3>
<p>Angular 2 builds on a reactive programming style using event-driven streams of data, rather than on the object-oriented approach you might see in MV* frameworks. In fact, data flow is the most interesting thing you won’t see mentioned on Angular 2''s features page.</p>
<p>It all starts with how the framework gets its data: Promises versus Observables. Promises are a method of triggering an asynchronous action, then handling the result when it''s ready. In contrast, Observables are <a href="https://github.com/zenparsing/es-observable" target="_blank">a proposed standard type</a> that allows subscription to a stream of values.</p>
<p>In his talk on data flow in Angular 2, <a href="https://vimeo.com/144625829" target="_blank">Rob Wormald</a> provides examples of “typeahead” functionality in AngularJS versus Angular 2, demonstrating the work required to debounce requests -- that is, to not waste HTTP requests while the user is still typing, yet still provide nearly instantaneous “typeahead” search results.</p>
<p>I’ve modified the code here to make it more understandable out of context. The value of this.searchResults is modified based on a typeahead field.</p>
<table border="0" cellspacing="0" cellpadding="0" class="stats">
<tbody>
<tr>
<td><strong>Angular 1</strong></td>
<td><strong>Angular 2</strong></td>
</tr>
<tr>
<td>// change event to be fired<br />// whenever the search box value changes<br />// creating timeouts to debounce the request<br />onSearchChanged() {<br /> var searchText = this.searchText;<br /> if(typeof this.searchTimeout !== ''number'') {<br />   clearTimeout(this.searchTimeout);<br />   this.searchTimeout = null;<br /> }<br /> this.searchTimeout = setTimeout(() =&gt; {<br />   this.doSearch(searchText);<br />   this.searchTimeout = null;<br /> }, 200)<br />}<br /><br />doSearch(searchText) {<br /> this.currentRequest = fetch(''/someendpoint?search=${searchText}'')<br />     .then(res =&gt; res.json())<br />     .then(results =&gt; this.searchResults = results)<br />}</td>
<td>this.searchResults = Observable.from((&lt;EventEmitter&gt;this.searchText.valueChanges).toRx())<br />   .debounceTime(200)<br />   .switchMap((val:string) =&gt; myService.load(val))<br />   .merge(this.clear.toRx().mapTo([]));</td>
</tr>
</tbody>
</table>
<p>As you can see, a simple reactive action (debounceTime) is required for Angular 2 to provide the same debounce functionality as AngularJS to get values intothis.searchResults.</p>
<p>In order to leverage Observables and reactive actions, Angular 2 employs <a href="https://github.com/ReactiveX/RxJS" target="_blank">the next version of RxJS</a>. That means users of Angular 2 also benefit from access to this reactive tooling (the ability to simply debounce a stream of events serving as an example), and Angular 2 users are likely provide more fuel for reactive programming champions.</p>
<h3>Choose your own language</h3>
<p>While AngularJS is a JavaScript framework, Angular 2 is a “whatever compiles to JavaScript” framework. As long as what you want to write in can compile to JavaScript, you can (probably) use Angular 2.</p>
<p>In the new Angular documentation, you’ll notice a drop-down for JavaScript, TypeScript, or Dart. While this might change (it looks like a beast of documentation work), it’s an indicator of the community’s intentions.</p>
<p>Angular 2 itself is written in <a href="http://www.typescriptlang.org/" target="_blank">TypeScript</a>, a typed superset of JavaScript. You can think of it in shorthand as “ES2015 with types.” While this may give TypeScript an edge in adoption, it’s clear that the framework authors intend Angular 2 to be friendly to transpiled languages in general.</p>
<p>Thanks to AngularJS''s popularity, adoption of Angular 2 will probably be huge. The new framework has a lot to show you regarding trends to pay attention to: JavaScript apps won’t have to be written in JavaScript (if they can make the compile target work). Reactive programming is on the rise, especially for browser apps. And the Web Components standard is sticking around -- even if the browser vendors haven''t ironed out how they will support it.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (416, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 86, NULL, NULL, NULL, NULL, N'Two years ago Google promised a major rewrite of AngularJS, which back then was already topping the charts as the most popular JavaScript framework. Now the new version, dubbed Angular 2, is finally nearing a beta release.

Angular 2 draws on the perspectives of experts who have both learned from experience and have an eye toward future standards. Now’s a great time to see what the framework authors are bringing to the next version.

[ Need a JavaScript tool for your dev shop? InfoWorld looks at 17 JavaScript editors and IDEs ready for adoption. | Keep up with hot topics in programming with InfoWorld''s Application Development newsletter. ]')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (417, 1121, N'3cd235e8-e9d5-4be1-920d-b102dc5a0e8d', 43, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (418, 1112, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (419, 1112, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (420, 1112, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (421, 1112, N'9b93fa1d-2f2f-4c45-9eba-cbf041895fed', 78, NULL, NULL, NULL, NULL, N'{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90",
          "active": false
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>somehtin somethign about vision</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>something something somethign</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Something something about the skills</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "active": true
        }
      ]
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (422, 1112, N'5195df88-ac00-4072-979f-2ef3464d1b71', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (423, 1112, N'5195df88-ac00-4072-979f-2ef3464d1b71', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (424, 1112, N'5195df88-ac00-4072-979f-2ef3464d1b71', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (425, 1112, N'5195df88-ac00-4072-979f-2ef3464d1b71', 78, NULL, NULL, NULL, NULL, N'{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                }
              ]
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90"
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>somehtin somethign about vision</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ]
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>something something somethign</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Something something about the skills</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ]
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "active": true
        }
      ]
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (426, 1112, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (427, 1112, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (428, 1112, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (429, 1112, N'29d9868f-cad4-4dad-978b-8b1882dc68f2', 78, NULL, NULL, NULL, NULL, N'{
  "name": "contactGrid",
  "sections": [
    {
      "grid": 12,
      "rows": [
        {
          "name": "Headline",
          "areas": [
            {
              "grid": 12,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Learn about WebDev",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>This site is focusing on the new technologies in the development world, we strive to educate people and give people the chance to become a part of a larger society and explore the new things that are sterring in the programming world.</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            }
          ],
          "hasConfig": false,
          "id": "fa51f962-ad83-2301-3c93-788d5f124d90",
          "active": false
        },
        {
          "name": "3colum",
          "areas": [
            {
              "grid": 4,
              "allowAll": true,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Vision",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>Our vission is to assemble a creat team of programmers to share projects and experience and together widen our collective horison to become better at our jobs, and create the future in programming</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "hasConfig": false,
              "controls": [
                {
                  "value": "People",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                },
                {
                  "value": "<p>We seek people who are passionate about programming and strives to learn new things but also share their experince with others.</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": false
                }
              ],
              "active": false
            },
            {
              "grid": 4,
              "allowAll": false,
              "hasConfig": false,
              "controls": [
                {
                  "value": "Skills",
                  "editor": {
                    "alias": "headline"
                  },
                  "active": false
                },
                {
                  "value": "<p>Your skills to join this awesome team could be anything from Android to PHP we want a wide net of programmers to share as much knowledge as possible</p>",
                  "editor": {
                    "alias": "rte"
                  },
                  "active": true
                }
              ],
              "active": true,
              "hasActiveChild": true
            }
          ],
          "hasConfig": false,
          "id": "2839b5fb-5973-489c-7f9a-1576345bab8e",
          "hasActiveChild": true,
          "active": true
        }
      ]
    }
  ]
}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (430, 1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (431, 1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (432, 1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (433, 1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', 48, NULL, NULL, NULL, N'Projects to join and seak inspiration', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (434, 1120, N'0a7df4c7-038d-4def-9c1d-568fda865bfb', 49, NULL, NULL, NULL, NULL, N'<p>See what type of projects that are going on in the Århus web develpåment group.</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (435, 1130, N'aad9bf99-da5c-45c2-834d-6163a51d007b', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (436, 1130, N'aad9bf99-da5c-45c2-834d-6163a51d007b', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (437, 1130, N'aad9bf99-da5c-45c2-834d-6163a51d007b', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (438, 1130, N'aad9bf99-da5c-45c2-834d-6163a51d007b', 85, NULL, NULL, NULL, N'Keep yourself updated!', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (439, 1131, N'cbe2c390-9d41-425f-819e-58bab291c22e', 82, NULL, NULL, NULL, NULL, N'Learn about Angular 2 it''s going to be the new things')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (440, 1131, N'cbe2c390-9d41-425f-819e-58bab291c22e', 80, NULL, NULL, CAST(N'2016-10-12 16:40:25.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (441, 1131, N'cbe2c390-9d41-425f-819e-58bab291c22e', 79, NULL, NULL, NULL, N'Angular 2 is out', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (442, 1131, N'cbe2c390-9d41-425f-819e-58bab291c22e', 81, NULL, NULL, NULL, N'Elias', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (443, 1130, N'e1fd8011-22c5-47ab-ad89-5e19ca24b410', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (444, 1130, N'e1fd8011-22c5-47ab-ad89-5e19ca24b410', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (445, 1130, N'e1fd8011-22c5-47ab-ad89-5e19ca24b410', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (446, 1130, N'e1fd8011-22c5-47ab-ad89-5e19ca24b410', 85, NULL, NULL, NULL, N'Keep yourself updated!', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (447, 1131, N'b6170db1-3fe7-46a2-808b-49286e309ec0', 82, NULL, NULL, NULL, NULL, N'Learn about Angular 2 it''s going to be the new things')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (448, 1131, N'b6170db1-3fe7-46a2-808b-49286e309ec0', 80, NULL, NULL, CAST(N'2016-10-12 16:40:25.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (449, 1131, N'b6170db1-3fe7-46a2-808b-49286e309ec0', 79, NULL, NULL, NULL, N'Angular 2 is out', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (450, 1131, N'b6170db1-3fe7-46a2-808b-49286e309ec0', 81, NULL, NULL, NULL, N'Elias', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (451, 1130, N'e7c8c962-e52e-401f-a621-7457aef2f1be', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (452, 1130, N'e7c8c962-e52e-401f-a621-7457aef2f1be', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (453, 1130, N'e7c8c962-e52e-401f-a621-7457aef2f1be', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (454, 1130, N'e7c8c962-e52e-401f-a621-7457aef2f1be', 85, NULL, NULL, NULL, N'Keep yourself updated!', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (455, 1131, N'd3cb6479-f887-410b-ba90-6b59c7a3a8b5', 82, NULL, NULL, NULL, NULL, N'Learn about Angular 2 it''s going to be the new things')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (456, 1131, N'd3cb6479-f887-410b-ba90-6b59c7a3a8b5', 80, NULL, NULL, CAST(N'2016-10-12 16:40:25.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (457, 1131, N'd3cb6479-f887-410b-ba90-6b59c7a3a8b5', 79, NULL, NULL, NULL, N'Angular 2 is out', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (458, 1131, N'd3cb6479-f887-410b-ba90-6b59c7a3a8b5', 81, NULL, NULL, NULL, N'Elias', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (459, 1133, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (460, 1133, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (461, 1133, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (462, 1133, N'1a57f0b0-9eed-4a74-9ddb-9f5ee14ab725', 85, NULL, NULL, NULL, N'Keep yourself updated!', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (463, 1133, N'67207c55-b02c-4338-9828-b8c365a07696', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (464, 1133, N'67207c55-b02c-4338-9828-b8c365a07696', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (465, 1133, N'67207c55-b02c-4338-9828-b8c365a07696', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (466, 1133, N'67207c55-b02c-4338-9828-b8c365a07696', 85, NULL, NULL, NULL, N'Keep yourself updated!', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (467, 1134, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', 82, NULL, NULL, NULL, NULL, N'something something')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (468, 1134, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', 80, NULL, NULL, CAST(N'2016-10-13 15:22:51.000' AS DateTime), NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (469, 1134, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', 79, NULL, NULL, NULL, N'Angular is back', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (470, 1134, N'62a1f003-1d34-4dc2-ba9e-b92d25c0c280', 81, NULL, NULL, NULL, N'daniel', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (471, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (472, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (473, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (474, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 83, NULL, NULL, NULL, NULL, N'<p>- Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (475, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 46, NULL, NULL, NULL, NULL, N'unending contact thing')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (476, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 38, NULL, NULL, NULL, NULL, N'<p>Welcome to Århus WebDevCoop this is wierd</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (477, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 47, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (479, 1075, N'fab6b5cf-a7ad-42f1-9483-3324751517a2', 37, NULL, NULL, NULL, N'WebDev community', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (480, 1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (481, 1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (482, 1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (483, 1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', 45, NULL, NULL, NULL, NULL, N'<p>You cannot acces this page, login, or contact us for acces to our website</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (484, 1094, N'618a9998-139a-49b9-bd29-5cb6a55152a9', 44, NULL, NULL, NULL, N'You are not allowed on the page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (485, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (486, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (487, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (488, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 83, NULL, NULL, NULL, N'Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (489, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 46, NULL, NULL, NULL, NULL, N'unending contact thing')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (490, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 88, NULL, NULL, NULL, N'New things on the world of programming', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (491, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 38, NULL, NULL, NULL, NULL, N'<p>Welcome to Århus WebDevCoop this is wierd</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (492, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 47, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (493, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 37, NULL, NULL, NULL, N'WebDev community', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (494, 1075, N'c2a28399-e6f2-4e42-a4a7-307aa3056646', 89, NULL, NULL, NULL, N'The site is live, all are welcome', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (495, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (496, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (497, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (498, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (499, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 54, NULL, NULL, NULL, N'15', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (500, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 87, NULL, NULL, NULL, NULL, N'This project is a small fun project to show of what umbraco can be used for.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (501, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (502, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 50, NULL, NULL, NULL, N'WebDev Coop Århus', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (503, 1123, N'd79e07c2-043c-4f6c-8724-6eb13c284e0a', 51, NULL, NULL, NULL, NULL, N'<p>This site is now live and you can check out the project below</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (504, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (505, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (506, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (507, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 52, NULL, NULL, NULL, N'', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (508, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 54, NULL, NULL, NULL, N'14', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (509, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 87, NULL, NULL, NULL, NULL, N'Android shoppinglist with hookup to firebase for a more comfortable experience')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (510, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (511, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 50, NULL, NULL, NULL, N'A shoppinglist for Android', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (512, 1124, N'7eb53bdb-e893-4cee-a2f0-ad90d1bf6e05', 51, NULL, NULL, NULL, NULL, N'<p>Check out the code below and make your own changes</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (513, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (514, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (515, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (516, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (517, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 54, NULL, NULL, NULL, N'15', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (518, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 87, NULL, NULL, NULL, NULL, N'This project is a small fun project to show of what umbraco can be used for.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (519, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (520, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 50, NULL, NULL, NULL, N'WebDev Coop Århus', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (521, 1123, N'aa2a5932-cbbe-4a44-826a-2119d8582b5c', 51, NULL, NULL, NULL, NULL, N'<p>This site is now live and you can check out the project below</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (522, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (523, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (524, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (525, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 52, NULL, NULL, NULL, N'', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (526, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 54, NULL, NULL, NULL, N'15', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (527, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 87, NULL, NULL, NULL, NULL, N'Mongo, Express, Angular, NodeJS')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (528, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 53, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (529, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 50, NULL, NULL, NULL, N'The MEAN stack', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (530, 1135, N'f6d79d31-e620-4fc4-9fe6-3e1f5fb8fdcf', 51, NULL, NULL, NULL, NULL, N'<p>Learn about mean stacks and what they have to offer</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (531, 1141, N'e20de96c-7af4-42ce-84cb-85c1a4980a50', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (532, 1141, N'e20de96c-7af4-42ce-84cb-85c1a4980a50', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (533, 1141, N'e20de96c-7af4-42ce-84cb-85c1a4980a50', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (534, 1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (535, 1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (536, 1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', 76, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (537, 1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', 45, NULL, NULL, NULL, NULL, N'<p>You cannot acces this page, login, or contact us for acces to our website</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (538, 1094, N'25156fe2-813f-496f-8f9d-a963c7087e8b', 44, NULL, NULL, NULL, N'You are not allowed on the page', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (539, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (540, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (541, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 76, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (542, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 83, NULL, NULL, NULL, N'Now you have the opportunity to learn from Allot of different people, share your work and maybe you will get something back', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (543, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 46, NULL, NULL, NULL, NULL, N'unending contact thing')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (544, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 88, NULL, NULL, NULL, N'New things on the world of programming', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (545, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 38, NULL, NULL, NULL, NULL, N'<p><strong>Welcome to Århus WebDevCoop</strong></p>
<p> </p>
<p style="padding-left: 30px;">Here you can enjoy and talk with other people abotu whats going on in the programming comunity</p>')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (546, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 47, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (547, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 37, NULL, NULL, NULL, N'WebDev community', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (548, 1075, N'52684f31-d806-4495-8d64-1dd500ecd8ce', 89, NULL, NULL, NULL, N'The site is live, all are welcome', NULL)
SET IDENTITY_INSERT [dbo].[cmsPropertyData] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyType] ON 

INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (6, 1043, 1032, 3, N'umbracoFile', N'Upload image', 0, 0, NULL, NULL, N'00000006-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (7, -92, 1032, 3, N'umbracoWidth', N'Width', 0, 0, NULL, NULL, N'00000007-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (8, -92, 1032, 3, N'umbracoHeight', N'Height', 0, 0, NULL, NULL, N'00000008-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (9, -92, 1032, 3, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'00000009-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (10, -92, 1032, 3, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'0000000a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (24, -90, 1033, 4, N'umbracoFile', N'Upload file', 0, 0, NULL, NULL, N'00000018-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (25, -92, 1033, 4, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'00000019-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (26, -92, 1033, 4, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'0000001a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (27, -96, 1031, 5, N'contents', N'Contents:', 0, 0, NULL, NULL, N'0000001b-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (28, -89, 1044, 11, N'umbracoMemberComments', N'Comments', 0, 0, NULL, NULL, N'0000001c-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (29, -92, 1044, 11, N'umbracoMemberFailedPasswordAttempts', N'Failed Password Attempts', 1, 0, NULL, NULL, N'0000001d-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (30, -49, 1044, 11, N'umbracoMemberApproved', N'Is Approved', 2, 0, NULL, NULL, N'0000001e-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (31, -49, 1044, 11, N'umbracoMemberLockedOut', N'Is Locked Out', 3, 0, NULL, NULL, N'0000001f-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (32, -92, 1044, 11, N'umbracoMemberLastLockoutDate', N'Last Lockout Date', 4, 0, NULL, NULL, N'00000020-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (33, -92, 1044, 11, N'umbracoMemberLastLogin', N'Last Login Date', 5, 0, NULL, NULL, N'00000021-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (34, -92, 1044, 11, N'umbracoMemberLastPasswordChangeDate', N'Last Password Change Date', 6, 0, NULL, NULL, N'00000022-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (35, 1060, 1048, 12, N'metaDescription', N'MetaDescription', 0, 0, NULL, NULL, N'dab2a46a-8062-453c-ab8d-93f846eb640b')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (36, 1061, 1048, 12, N'metaKeywords', N'MetaKeywords', 1, 0, NULL, NULL, N'f7dc0a20-73f3-49aa-bdde-1d41ff9604fe')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (37, -88, 1050, 13, N'header', N'Header1', 0, 0, NULL, NULL, N'14cb5e7a-f2fd-44c5-9667-f78c2cfefe87')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (38, -87, 1050, 13, N'frontpageText', N'SiteDescription', 1, 0, NULL, NULL, N'1dd106f7-2cbc-409f-8416-ce5654f232e9')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (39, -88, 1052, 14, N'articlesHeader', N'ArticlesHeader', 0, 0, NULL, NULL, N'6ca89908-a84a-4407-ab14-0beb68c3c526')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (40, -87, 1052, 14, N'articlesText', N'Articles Text', 1, 0, NULL, NULL, N'c72545e3-669d-473d-b23d-0d1cbb59d028')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (41, -88, 1055, 15, N'articleHeader', N'Article Header', 0, 0, NULL, NULL, N'd454cf68-5f11-4a53-a04e-2d5c6c38e040')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (42, -87, 1055, 15, N'articleMainText', N'ArticleMainText', 1, 0, NULL, NULL, N'60157b5c-2fb2-4015-ab70-464630a7bfa0')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (43, 1043, 1055, 15, N'articlePicture', N'Article Picture', 2, 0, NULL, NULL, N'b06431b8-7cb0-4cc0-bae6-bf0baaa9f670')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (44, -88, 1058, 16, N'textPageHeader', N'Text page header', 0, 0, NULL, NULL, N'75622b79-7819-4be8-9877-abd10c314d1d')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (45, 1056, 1058, 16, N'textPageMain', N'text page main', 1, 0, NULL, NULL, N'c1a2bca4-f07e-4769-9702-a1a750322d19')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (46, 1063, 1050, 13, N'footer', N'Footer', 2, 0, NULL, NULL, N'b25e0093-f0cc-46b5-8d71-23f21400176a')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (47, 1065, 1050, 13, N'logo', N'Logo', 3, 0, NULL, NULL, N'f9a224ad-98b8-47c8-af63-d0a4783499fe')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (48, 1068, 1067, 17, N'projectsHeader', N'projects header', 0, 0, NULL, NULL, N'fe5aca1b-67b4-4acd-8d0f-320f76215f82')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (49, 1069, 1067, 17, N'projectsDescription', N'Projects Description', 1, 0, NULL, NULL, N'44a6530b-571a-4bbd-84df-4385fafd4345')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (50, -88, 1071, 18, N'projectHeader', N'Project header', 0, 0, NULL, NULL, N'61171a6d-ef4c-4d42-9498-bd6b65e76727')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (51, 1072, 1071, 18, N'projectText', N'Project Text', 1, 0, NULL, NULL, N'b0515210-828e-4be3-8c38-d23389768e9d')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (52, 1073, 1071, 18, N'projectFiles', N'Project files', 2, 0, NULL, NULL, N'67c53436-3323-40e0-91d0-0e10043457a9')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (53, 1074, 1071, 18, N'projectsImage', N'projects Image', 3, 0, NULL, NULL, N'954800fd-bc71-4751-bcfc-789183a5f63b')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (54, 1062, 1071, 18, N'projectStatus', N'Project status', 4, 0, NULL, NULL, N'17858980-a2e4-4cec-858f-1b05361031d0')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (55, -92, 1044, NULL, N'umbracoMemberPasswordRetrievalAnswer', N'Password Answer', 0, 0, NULL, NULL, N'6766b1e2-a274-4ce7-921a-811222d0c896')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (56, -92, 1044, NULL, N'umbracoMemberPasswordRetrievalQuestion', N'Password Question', 1, 0, NULL, NULL, N'2677c7ae-22d8-4833-8836-7477e9ada4e5')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (57, -88, 1044, 19, N'firstName', N'First Name', 0, 0, NULL, NULL, N'86efd28d-ae85-4364-b81a-708475b32f08')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (58, -88, 1044, 19, N'lastName', N'Last Name', 1, 0, NULL, NULL, N'dddf7f97-44da-4f65-a89f-c25b72baf7a4')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (59, -88, 1044, 19, N'address', N'Address', 2, 0, NULL, NULL, N'4e79c518-ac1b-4d77-9388-a6218a524a05')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (60, -88, 1044, 19, N'zipcode', N'Zipcode', 3, 0, NULL, NULL, N'92f596c0-251f-4c44-b146-7b251a411e71')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (61, -88, 1044, 19, N'city', N'City', 4, 0, NULL, NULL, N'e0a32c9e-12d2-497a-ad4d-fbc868edf739')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (62, -88, 1044, 19, N'phoneNr', N'PhoneNr', 5, 0, NULL, NULL, N'539d8f84-c723-47cc-aca8-255670e8ce31')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (63, 1043, 1044, 20, N'avatar', N'Avatar', 0, 0, NULL, NULL, N'fb8c499c-406f-45d2-a9c2-8a4e0b2ad367')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (64, -88, 1087, 21, N'firstname', N'Firstname', 0, 0, NULL, NULL, N'648981b8-eb32-48c8-8cc2-5e5be08b755f')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (65, -88, 1087, 21, N'lastname', N'Lastname', 1, 0, NULL, NULL, N'b37056e5-a48d-4ab5-b248-933fe41907f8')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (66, -88, 1087, 21, N'phoneNr', N'PhoneNr', 2, 0, NULL, NULL, N'81abafd0-410f-4c19-aed9-8a48c2c7753f')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (67, -89, 1087, 22, N'umbracoMemberComments', N'Comments', 0, 0, NULL, NULL, N'742acb52-47fb-465b-8b2d-1c33e0188ca3')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (68, -92, 1087, 22, N'umbracoMemberFailedPasswordAttempts', N'Failed Password Attempts', 1, 0, NULL, NULL, N'54451f90-5b0f-43db-8bef-68f72cf3ab29')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (69, -49, 1087, 22, N'umbracoMemberApproved', N'Is Approved', 2, 0, NULL, NULL, N'82fe1ef6-5525-496a-8bac-23336acccad3')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (70, -49, 1087, 22, N'umbracoMemberLockedOut', N'Is Locked Out', 3, 0, NULL, NULL, N'f86781fb-ace6-4e85-acd2-c047cbece071')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (71, -92, 1087, 22, N'umbracoMemberLastLockoutDate', N'Last Lockout Date', 4, 0, NULL, NULL, N'27296625-386a-43f3-9eb1-2d5bc4b995fe')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (72, -92, 1087, 22, N'umbracoMemberLastLogin', N'Last Login Date', 5, 0, NULL, NULL, N'fddc5b5f-e749-4163-bc26-082034d785a3')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (73, -92, 1087, 22, N'umbracoMemberLastPasswordChangeDate', N'Last Password Change Date', 6, 0, NULL, NULL, N'26391a8b-b357-45ee-bade-0de9842a1aff')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (74, -92, 1087, 22, N'umbracoMemberPasswordRetrievalAnswer', N'Password Answer', 7, 0, NULL, NULL, N'a1f1cbb9-a1d1-4cde-a94c-a625a02c6946')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (75, -92, 1087, 22, N'umbracoMemberPasswordRetrievalQuestion', N'Password Question', 8, 0, NULL, NULL, N'09772a68-8e0b-4780-9772-21bb424b4f51')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (76, 1096, 1048, 23, N'UmbracoNaviHide', N'Hide in Navigation?', 0, 0, NULL, NULL, N'132249b1-f2d1-498a-ae86-d666c966033f')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (78, 1107, 1110, 25, N'aboutGrid', N'AboutGrid', 0, 0, NULL, NULL, N'562b2905-be36-40a6-b8ef-a1f0a6c71c94')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (79, -88, 1118, 26, N'title', N'Title', 0, 0, NULL, NULL, N'8ad79111-3130-4832-a6fc-e51a129a102c')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (80, 1114, 1118, 26, N'date', N'Date', 1, 0, NULL, NULL, N'77fa047b-d829-4a9b-b23a-54171fa42c84')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (81, -88, 1118, 26, N'publisher', N'publisher', 2, 0, NULL, NULL, N'b8a91364-6c33-42a1-af97-ead9ca3feed7')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (82, 1116, 1118, 26, N'content', N'Content', 3, 0, NULL, NULL, N'445d8a50-de27-4e95-8577-4559dfa68af6')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (83, -88, 1050, 13, N'quote1', N'quote1', 4, 0, NULL, NULL, N'09d6fd96-cc73-4814-9ae3-183e97578868')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (85, -88, 1126, 27, N'title', N'Title', 0, 0, NULL, NULL, N'919550ba-5900-481f-ab06-5642acea4307')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (86, 1128, 1055, 15, N'preview', N'preview', 3, 0, NULL, NULL, N'18bd3b85-9bb1-4298-831c-843a3d47b498')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (87, 1129, 1071, 18, N'preview', N'preview', 5, 0, NULL, NULL, N'91aef191-4c81-4d07-a07e-2c3ae587dd13')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (88, -88, 1050, 13, N'quote3', N'quote3', 6, 0, NULL, NULL, N'cced75f6-a600-4b83-a09a-b4ffaa57bbed')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (89, -88, 1050, 13, N'quote2', N'quote2', 7, 0, NULL, NULL, N'cada0422-200f-40b3-ae44-fbae4871a331')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (90, -88, 1138, 28, N'asker', N'Asker', 0, 1, NULL, NULL, N'41c53164-62df-4e96-a690-f846e5663f01')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (91, -88, 1138, 28, N'subject', N'Subject', 1, 1, NULL, NULL, N'ece24664-90af-409f-ad8e-7e17feb26f12')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (92, 1136, 1138, 28, N'email', N'Email', 2, 1, N'[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+', NULL, N'0b502731-44f0-4f84-b268-7d87c4d06b5f')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (93, -89, 1138, 28, N'message', N'Message', 3, 1, NULL, NULL, N'cc658e2d-d937-4ed0-ab01-05835483e14d')
SET IDENTITY_INSERT [dbo].[cmsPropertyType] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] ON 

INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (3, 1032, N'Image', 1, N'79ed4d07-254a-42cf-8fa9-ebe1c116a596')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (4, 1033, N'File', 1, N'50899f9c-023a-4466-b623-aba9049885fe')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (5, 1031, N'Contents', 1, N'79995fa2-63ee-453c-a29b-2e66f324cdbe')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (11, 1044, N'Membership', 1, N'0756729d-d665-46e3-b84a-37aceaa614f8')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (12, 1048, N'SEO', 0, N'1f02ebea-10b1-4e6c-a195-fa22baa79807')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (13, 1050, N'content', 1, N'a1fd6871-edbf-4b72-857b-f17a9df702e0')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (14, 1052, N'content', 1, N'707baf16-c1ef-4489-9a9b-33100d456d53')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (15, 1055, N'content', 1, N'c3174b20-e8a9-48e2-91b7-9d5e85b4723f')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (16, 1058, N'content', 1, N'27045dbc-58e1-4f79-92bc-7ba65dbdbed6')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (17, 1067, N'content', 1, N'7c51aef7-b16e-4f3f-817f-f5de98218fd8')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (18, 1071, N'content', 1, N'de3918a0-177e-42e7-8deb-c5df21b1449d')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (19, 1044, N'Member info', 2, N'8ab5fbf9-dca9-4ccf-8b1a-23fe1e5b5b01')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (20, 1044, N'Member Photo', 3, N'8f54288b-29b7-4698-b1f6-9d6ffadaa171')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (21, 1087, N'Member info', 0, N'87ae9802-bbbc-4c0c-be1f-de6ae4c97149')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (22, 1087, N'Membership', 1, N'3bc3461b-2c2b-4518-be09-9623b63f9234')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (23, 1048, N'NaviHide', 1, N'b175ad08-6bf2-4690-9e32-1b31f723d076')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (25, 1110, N'content', 2, N'3239118f-ed2a-48af-ad29-14eb122ad383')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (26, 1118, N'content', 0, N'5d2bbd9e-0cda-4aeb-a2ef-ee56c19a27a4')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (27, 1126, N'content', 2, N'389c3d26-ca1e-4a85-bb34-af7144e2d8a0')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (28, 1138, N'content', 0, N'ee346867-093d-4025-a130-24daa95d0208')
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] OFF
SET IDENTITY_INSERT [dbo].[cmsTaskType] ON 

INSERT [dbo].[cmsTaskType] ([id], [alias]) VALUES (1, N'toTranslate')
SET IDENTITY_INSERT [dbo].[cmsTaskType] OFF
SET IDENTITY_INSERT [dbo].[cmsTemplate] ON 

INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (10, 1100, N'Master', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = null;
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (11, 1101, N'Home', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

<section class="col-md-12">
    <h2>@Umbraco.Field("header")</h2>

</section>

<section class="col-md-6 section">
    <div class="section-primary fade-color-blue">
		@Umbraco.Field("frontpageText")
        <div class="quote-box">
            <p class="quote"> - @Umbraco.Field("quote1")</p>
        </div>
    </div>
</section>
<section class="col-md-6 section">
    <div class="col-md-12 section-right fade-color-orange">
        <div class="quote-box">
            <p class="quote"> - @Umbraco.Field("quote2")</p>
        </div>
    </div>
    <div class="col-md-12 section-right fade-color-green">
        <div class="quote-box">
            <p class="quote"> - @Umbraco.Field("quote3")</p>
        </div>
    </div>
</section>



')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (12, 1102, N'ProjectMain', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (13, 1103, N'ProjectItem', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (14, 1104, N'ArticleMain', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@Umbraco.Field("articlesHeader")
@Umbraco.Field("articlesText")

@Html.Partial("ChildList")')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (15, 1105, N'ArticleItem', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@Umbraco.Field("articleHeader")
<img src="@CurrentPage.GetCropUrl("image")"/>
@Umbraco.Field("articleMainText")')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (16, 1106, N'Textpage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (17, 1109, N'AboutPage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.AboutPage>
@using ContentModels = Umbraco.Web.PublishedContentModels;
@{
	Layout = "Master.cshtml";
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (18, 1111, N'ContactPage', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (19, 1113, N'Login', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@Html.Partial("Login")')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (22, 1132, N'MessageBoard', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

<div class="viewScreen col-md-12">
    <div class="col-md-10 col-md-offset-1">
        <h2>@Umbraco.Field("title")</h2>
        @Html.Partial("MessageBoard")
    </div>
    <div class="col-md-10 col-md-offset-1">
        @Html.Partial("MessageForm")
    </div>
</div>')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (24, 1140, N'MemberView', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (25, 1142, N'ForbiddenAcces', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

<div class="viewScreen col-md-12">
    <div class="col-md-10 col-md-offset-1 text-center">
        <h2 class="text-danger">@Umbraco.Field("textPageHeader")</h2>
        <h4>@Umbraco.Field("textPageMain")</h4>
    </div>
</div>')
SET IDENTITY_INSERT [dbo].[cmsTemplate] OFF
INSERT [dbo].[umbracoAccess] ([id], [nodeId], [loginNodeId], [noAccessNodeId], [createDate], [updateDate]) VALUES (N'408f3206-15cb-4b05-8a5f-6f9c8096eaf5', 1141, 1092, 1094, CAST(N'2016-10-13 17:46:56.537' AS DateTime), CAST(N'2016-10-13 17:46:56.563' AS DateTime))
INSERT [dbo].[umbracoAccess] ([id], [nodeId], [loginNodeId], [noAccessNodeId], [createDate], [updateDate]) VALUES (N'6a5651f9-3d2c-4823-8e68-72aa31c4ec09', 1133, 1092, 1094, CAST(N'2016-10-13 16:36:55.207' AS DateTime), CAST(N'2016-10-13 16:36:55.227' AS DateTime))
INSERT [dbo].[umbracoAccess] ([id], [nodeId], [loginNodeId], [noAccessNodeId], [createDate], [updateDate]) VALUES (N'888ae1c1-5e8f-48df-bcce-80ff40cd87c2', 1120, 1092, 1094, CAST(N'2016-10-13 16:35:12.413' AS DateTime), CAST(N'2016-10-13 16:35:12.437' AS DateTime))
INSERT [dbo].[umbracoAccess] ([id], [nodeId], [loginNodeId], [noAccessNodeId], [createDate], [updateDate]) VALUES (N'44e28999-91cb-4b7c-b7b4-e07a47bc4748', 1077, 1092, 1094, CAST(N'2016-09-26 10:23:28.347' AS DateTime), CAST(N'2016-10-10 11:32:14.213' AS DateTime))
INSERT [dbo].[umbracoAccessRule] ([id], [accessId], [ruleValue], [ruleType], [createDate], [updateDate]) VALUES (N'377b0aa0-e549-442b-888e-30ba96fbff27', N'408f3206-15cb-4b05-8a5f-6f9c8096eaf5', N'Active', N'MemberRole', CAST(N'2016-10-13 17:46:56.557' AS DateTime), CAST(N'2016-10-13 17:46:56.563' AS DateTime))
INSERT [dbo].[umbracoAccessRule] ([id], [accessId], [ruleValue], [ruleType], [createDate], [updateDate]) VALUES (N'74b8efd1-0683-4099-a2aa-4ea00bf2846f', N'44e28999-91cb-4b7c-b7b4-e07a47bc4748', N'Active', N'MemberRole', CAST(N'2016-09-26 10:23:29.843' AS DateTime), CAST(N'2016-10-10 11:32:14.217' AS DateTime))
INSERT [dbo].[umbracoAccessRule] ([id], [accessId], [ruleValue], [ruleType], [createDate], [updateDate]) VALUES (N'5bb98428-4394-4939-a17f-6efc762b052e', N'408f3206-15cb-4b05-8a5f-6f9c8096eaf5', N'Prospect', N'MemberRole', CAST(N'2016-10-13 17:46:56.563' AS DateTime), CAST(N'2016-10-13 17:46:56.563' AS DateTime))
INSERT [dbo].[umbracoAccessRule] ([id], [accessId], [ruleValue], [ruleType], [createDate], [updateDate]) VALUES (N'36922ae8-9d3e-4c54-a62f-729b8d95b41b', N'888ae1c1-5e8f-48df-bcce-80ff40cd87c2', N'Active', N'MemberRole', CAST(N'2016-10-13 16:35:12.437' AS DateTime), CAST(N'2016-10-13 16:35:12.437' AS DateTime))
INSERT [dbo].[umbracoAccessRule] ([id], [accessId], [ruleValue], [ruleType], [createDate], [updateDate]) VALUES (N'01a4b5d9-0708-4d14-82ec-c61eb1464484', N'6a5651f9-3d2c-4823-8e68-72aa31c4ec09', N'Active', N'MemberRole', CAST(N'2016-10-13 16:36:55.220' AS DateTime), CAST(N'2016-10-13 16:36:55.227' AS DateTime))
INSERT [dbo].[umbracoAccessRule] ([id], [accessId], [ruleValue], [ruleType], [createDate], [updateDate]) VALUES (N'b78ca8ee-a6fa-4d91-864a-e3f3ca1d3b9a', N'6a5651f9-3d2c-4823-8e68-72aa31c4ec09', N'Prospect', N'MemberRole', CAST(N'2016-10-13 16:36:55.227' AS DateTime), CAST(N'2016-10-13 16:36:55.227' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoCacheInstruction] ON 

INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (168, CAST(N'2016-10-11 16:05:59.423' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1117]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D2] EB10224FEFC74403A0FD02C820BFD117')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (169, CAST(N'2016-10-11 16:06:05.243' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1117]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D2] EB10224FEFC74403A0FD02C820BFD117')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (170, CAST(N'2016-10-11 18:11:58.773' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"homePage\",\"Id\":1050,\"PropertyTypeIds\":[37,38,46,47,83,84],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D5] 643E4CC7001943ADBF4C37F4F6D74007')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (171, CAST(N'2016-10-11 18:12:49.373' AS DateTime), N'[{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1076,"JsonIds":null,"JsonPayload":null},{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1093,"JsonIds":null,"JsonPayload":null},{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1079,"JsonIds":null,"JsonPayload":null},{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1078,"JsonIds":null,"JsonPayload":null},{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1076,1093,1079,1078]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (172, CAST(N'2016-10-11 18:12:54.403' AS DateTime), N'[{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1077,"JsonIds":null,"JsonPayload":null},{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1080,"JsonIds":null,"JsonPayload":null},{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1081,"JsonIds":null,"JsonPayload":null},{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1077,1080,1081]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (173, CAST(N'2016-10-11 18:14:05.720' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1119]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (174, CAST(N'2016-10-11 18:15:05.667' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (175, CAST(N'2016-10-11 18:15:47.120' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (176, CAST(N'2016-10-11 18:16:21.610' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (177, CAST(N'2016-10-11 18:16:52.057' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1122]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (178, CAST(N'2016-10-11 18:17:32.370' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (179, CAST(N'2016-10-11 18:17:45.417' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (180, CAST(N'2016-10-11 18:18:26.420' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (181, CAST(N'2016-10-11 18:21:56.620' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"projectMain\",\"Id\":1067,\"PropertyTypeIds\":[48,49],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (182, CAST(N'2016-10-11 18:22:06.063' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"projectsItem\",\"Id\":1071,\"PropertyTypeIds\":[50,51,52,53,54],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (183, CAST(N'2016-10-11 18:22:18.940' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"articleMain\",\"Id\":1052,\"PropertyTypeIds\":[39,40],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (184, CAST(N'2016-10-11 18:22:25.497' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"articleItem\",\"Id\":1055,\"PropertyTypeIds\":[41,42,43],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (185, CAST(N'2016-10-11 18:22:42.887' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessage\",\"Id\":1118,\"PropertyTypeIds\":[79,80,81,82],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (186, CAST(N'2016-10-11 18:24:25.080' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessage\",\"Id\":1118,\"PropertyTypeIds\":[79,80,81,82],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (187, CAST(N'2016-10-11 18:25:36.843' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null},{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":true,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":true}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (188, CAST(N'2016-10-11 18:25:52.947' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1117]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (189, CAST(N'2016-10-11 18:26:20.413' AS DateTime), N'[{"RefreshType":5,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1117,"JsonIds":null,"JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (190, CAST(N'2016-10-11 18:26:46.397' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (191, CAST(N'2016-10-11 18:27:02.827' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (192, CAST(N'2016-10-11 18:27:23.020' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (193, CAST(N'2016-10-11 18:27:38.807' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5216/D6] EBE57D03A4D04D00843735E6649AA008')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (194, CAST(N'2016-10-11 19:48:16.493' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"textPage\",\"Id\":1058,\"PropertyTypeIds\":[44,45],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (195, CAST(N'2016-10-11 19:48:30.373' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1092]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1092]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (196, CAST(N'2016-10-11 19:48:37.807' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1094]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1094]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (197, CAST(N'2016-10-11 19:48:44.450' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1108]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1108]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (198, CAST(N'2016-10-11 19:48:49.447' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (199, CAST(N'2016-10-11 19:48:57.783' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (200, CAST(N'2016-10-11 19:49:03.660' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1122]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1122]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (201, CAST(N'2016-10-11 19:49:09.110' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1119]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1119]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (202, CAST(N'2016-10-11 19:49:21.747' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (203, CAST(N'2016-10-11 19:49:28.350' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (204, CAST(N'2016-10-11 19:49:36.040' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (205, CAST(N'2016-10-11 19:51:29.730' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1104]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (206, CAST(N'2016-10-11 19:51:55.253' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1104]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (207, CAST(N'2016-10-11 19:52:36.400' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1105]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D2] E1EE44048EAA480A8F3EC89EA4AE16B1')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (208, CAST(N'2016-10-12 01:26:12.083' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1092]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1092]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D3] B9F73734F96E4B66BC6099F3B769B019')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (209, CAST(N'2016-10-12 01:30:38.723' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D3] B9F73734F96E4B66BC6099F3B769B019')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (210, CAST(N'2016-10-12 01:30:55.740' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D3] B9F73734F96E4B66BC6099F3B769B019')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (211, CAST(N'2016-10-12 02:00:31.523' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D4] 5523028E4AAD4E548D6264E950B45E63')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (212, CAST(N'2016-10-12 02:01:03.183' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D4] 5523028E4AAD4E548D6264E950B45E63')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (213, CAST(N'2016-10-12 02:01:34.993' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D4] 5523028E4AAD4E548D6264E950B45E63')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (214, CAST(N'2016-10-12 02:10:55.460' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1092]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1092]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P11788/D4] 5523028E4AAD4E548D6264E950B45E63')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (215, CAST(N'2016-10-12 09:52:27.000' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (216, CAST(N'2016-10-12 10:05:45.847' AS DateTime), N'[{"RefreshType":4,"RefresherId":"b29286dd-2d40-4ddb-b325-681226589fec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Path\":\"-1,1127\",\"Id\":1127,\"Operation\":0}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (217, CAST(N'2016-10-12 10:05:55.593' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (218, CAST(N'2016-10-12 10:07:36.607' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"articleItem\",\"Id\":1055,\"PropertyTypeIds\":[41,42,43],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (219, CAST(N'2016-10-12 10:09:04.420' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1105]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (220, CAST(N'2016-10-12 10:09:43.030' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"2fb39aef-9f01-4f12-babc-b3b27f447622\",\"Id\":1128}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (221, CAST(N'2016-10-12 10:09:49.770' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"articleItem\",\"Id\":1055,\"PropertyTypeIds\":[41,42,43,86],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (222, CAST(N'2016-10-12 10:10:27.597' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (223, CAST(N'2016-10-12 10:10:53.043' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (224, CAST(N'2016-10-12 10:14:48.473' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (225, CAST(N'2016-10-12 10:16:51.097' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1105]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D3] 213A8DD12B5742DA9CDCDC857EB7E365')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (226, CAST(N'2016-10-12 10:22:11.140' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"1df9f033-e6d4-451f-b8d2-e0cbc50a836f\",\"Id\":1043}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (227, CAST(N'2016-10-12 10:23:04.300' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (228, CAST(N'2016-10-12 10:23:30.523' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"1df9f033-e6d4-451f-b8d2-e0cbc50a836f\",\"Id\":1043}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (229, CAST(N'2016-10-12 10:23:49.813' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (230, CAST(N'2016-10-12 10:25:58.023' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"1df9f033-e6d4-451f-b8d2-e0cbc50a836f\",\"Id\":1043}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (231, CAST(N'2016-10-12 10:26:32.837' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (232, CAST(N'2016-10-12 10:27:19.070' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"1df9f033-e6d4-451f-b8d2-e0cbc50a836f\",\"Id\":1043}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (233, CAST(N'2016-10-12 10:31:02.497' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P8100/D4] 5DCFF355ABFE42E4A31928DCF3BF54BA')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1233, CAST(N'2016-10-12 12:16:08.663' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"b0196790-ce7d-4060-8d6b-ff5fdee02c2b\",\"Id\":1107}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D3] D497C2695DBE423285868F71227E6A6F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1234, CAST(N'2016-10-12 12:22:21.873' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D3] D497C2695DBE423285868F71227E6A6F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1235, CAST(N'2016-10-12 12:22:26.143' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D3] D497C2695DBE423285868F71227E6A6F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1236, CAST(N'2016-10-12 12:28:02.200' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1112]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D3] D497C2695DBE423285868F71227E6A6F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1237, CAST(N'2016-10-12 12:39:12.447' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1120]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D4] 5D482337418241F5872AA1A95127E426')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1238, CAST(N'2016-10-12 12:39:50.887' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"b09e00f1-c2f0-4aa2-8d37-204fcc60d3b6\",\"Id\":1129}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D4] 5D482337418241F5872AA1A95127E426')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1239, CAST(N'2016-10-12 12:39:54.817' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"projectsItem\",\"Id\":1071,\"PropertyTypeIds\":[50,51,52,53,54,87],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P4412/D4] 5D482337418241F5872AA1A95127E426')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1240, CAST(N'2016-10-12 14:36:30.787' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"homePage\",\"Id\":1050,\"PropertyTypeIds\":[37,38,46,47,83,84],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1241, CAST(N'2016-10-12 14:36:36.930' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1242, CAST(N'2016-10-12 14:37:17.420' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1243, CAST(N'2016-10-12 14:38:07.903' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1244, CAST(N'2016-10-12 14:38:47.010' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1245, CAST(N'2016-10-12 14:38:51.267' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1246, CAST(N'2016-10-12 14:39:07.920' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1247, CAST(N'2016-10-12 14:39:31.203' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1248, CAST(N'2016-10-12 14:40:13.233' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1130]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1249, CAST(N'2016-10-12 14:41:32.103' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1131]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P7560/D2] 7C2267586A744D6FBECB8FC1B73A779B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1250, CAST(N'2016-10-13 11:12:39.260' AS DateTime), N'[{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1130,"JsonIds":null,"JsonPayload":null},{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1131,"JsonIds":null,"JsonPayload":null},{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1130,1131]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1251, CAST(N'2016-10-13 11:13:32.277' AS DateTime), N'[{"RefreshType":5,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1125,"JsonIds":null,"JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1252, CAST(N'2016-10-13 11:13:43.907' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1253, CAST(N'2016-10-13 11:13:53.087' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1254, CAST(N'2016-10-13 11:14:10.300' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessage\",\"Id\":1118,\"PropertyTypeIds\":[79,80,81,82],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1255, CAST(N'2016-10-13 11:14:40.940' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1133]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1256, CAST(N'2016-10-13 11:15:22.093' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1257, CAST(N'2016-10-13 11:15:34.240' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1258, CAST(N'2016-10-13 11:15:48.603' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1133]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1133]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D2] AB709D890C9C4A9090A94A3692C8609F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1259, CAST(N'2016-10-13 11:33:50.300' AS DateTime), N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1088]","JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1088]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D3] 14C8B4A5CF4641C48C569052986B9D3A')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1260, CAST(N'2016-10-13 11:39:17.737' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessage\",\"Id\":1118,\"PropertyTypeIds\":[79,80,81,82],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D3] 14C8B4A5CF4641C48C569052986B9D3A')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1261, CAST(N'2016-10-13 11:40:01.160' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"boardMessages\",\"Id\":1126,\"PropertyTypeIds\":[85],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9540/D4] 153249A6FEC84B00B8552326BAAF3544')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1262, CAST(N'2016-10-13 13:22:51.333' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1134]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5556/D2] 2D1F7A684B24413FA5DF150C80F5675E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1263, CAST(N'2016-10-13 13:43:33.817' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1075]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1075]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10040/D2] 85D012361EE2414BAD450D52CD7B51E0')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1264, CAST(N'2016-10-13 13:44:23.117' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1094]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1094]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10040/D2] 85D012361EE2414BAD450D52CD7B51E0')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1265, CAST(N'2016-10-13 13:47:04.823' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"homePage\",\"Id\":1050,\"PropertyTypeIds\":[37,38,46,47,83,88,89],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10040/D2] 85D012361EE2414BAD450D52CD7B51E0')
GO
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1266, CAST(N'2016-10-13 13:47:13.190' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"homePage\",\"Id\":1050,\"PropertyTypeIds\":[37,38,46,47,83,88,89],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10040/D2] 85D012361EE2414BAD450D52CD7B51E0')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1267, CAST(N'2016-10-13 13:47:56.777' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1075]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1075]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10040/D2] 85D012361EE2414BAD450D52CD7B51E0')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1268, CAST(N'2016-10-13 14:05:15.930' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D2] AC99F6A938EF4043B21FE7B4B8FA6ECC')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1269, CAST(N'2016-10-13 14:05:51.457' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D2] AC99F6A938EF4043B21FE7B4B8FA6ECC')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1270, CAST(N'2016-10-13 14:06:01.573' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D2] AC99F6A938EF4043B21FE7B4B8FA6ECC')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1271, CAST(N'2016-10-13 14:06:46.643' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D2] AC99F6A938EF4043B21FE7B4B8FA6ECC')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1272, CAST(N'2016-10-13 14:29:34.253' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1135]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D3] 6E706FBDA461464F8104E2A0A995D5EE')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1273, CAST(N'2016-10-13 14:35:12.463' AS DateTime), N'[{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null},{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D3] 6E706FBDA461464F8104E2A0A995D5EE')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1274, CAST(N'2016-10-13 14:36:55.240' AS DateTime), N'[{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null},{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null},{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D3] 6E706FBDA461464F8104E2A0A995D5EE')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1275, CAST(N'2016-10-13 14:38:46.027' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"UniqueId\":\"34edf175-65c4-4906-a718-d0265d0269c8\",\"Id\":1136}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D3] 6E706FBDA461464F8104E2A0A995D5EE')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1276, CAST(N'2016-10-13 14:41:05.747' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1137]","JsonPayload":null},{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"contactForm\",\"Id\":1138,\"PropertyTypeIds\":[90,91,92,93],\"Type\":\"IContentType\",\"AliasChanged\":true,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":true}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P5332/D3] 6E706FBDA461464F8104E2A0A995D5EE')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1277, CAST(N'2016-10-13 15:06:35.840' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"memberView\",\"Id\":1139,\"PropertyTypeIds\":[],\"Type\":\"IContentType\",\"AliasChanged\":true,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":true}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9340/D2] FEC41F7793184737861391A9181EC80F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1278, CAST(N'2016-10-13 15:06:55.207' AS DateTime), N'[{"RefreshType":5,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1137,"JsonIds":null,"JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9340/D2] FEC41F7793184737861391A9181EC80F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1279, CAST(N'2016-10-13 15:07:21.410' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1140]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9340/D2] FEC41F7793184737861391A9181EC80F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1280, CAST(N'2016-10-13 15:07:25.717' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1140]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9340/D2] FEC41F7793184737861391A9181EC80F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1281, CAST(N'2016-10-13 15:07:39.647' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"memberView\",\"Id\":1139,\"PropertyTypeIds\":[],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P9340/D2] FEC41F7793184737861391A9181EC80F')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1282, CAST(N'2016-10-13 15:38:32.380' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"homePage\",\"Id\":1050,\"PropertyTypeIds\":[37,38,46,47,83,88,89],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1283, CAST(N'2016-10-13 15:39:21.937' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"memberView\",\"Id\":1139,\"PropertyTypeIds\":[],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1284, CAST(N'2016-10-13 15:39:39.933' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1141]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1285, CAST(N'2016-10-13 15:41:56.273' AS DateTime), N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1089]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1286, CAST(N'2016-10-13 15:42:35.880' AS DateTime), N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1090]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1287, CAST(N'2016-10-13 15:46:20.453' AS DateTime), N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1089]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1288, CAST(N'2016-10-13 15:46:56.583' AS DateTime), N'[{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null},{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null},{"RefreshType":0,"RefresherId":"1db08769-b104-4f8b-850e-169cac1df2ec","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1289, CAST(N'2016-10-13 15:47:29.297' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1142]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1290, CAST(N'2016-10-13 15:47:40.700' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1142]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1291, CAST(N'2016-10-13 15:47:51.963' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"textPage\",\"Id\":1058,\"PropertyTypeIds\":[44,45],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D2] 6947F8C09CB64E6F95C248249149DD33')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1292, CAST(N'2016-10-13 15:48:11.053' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1094]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1094]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P10496/D3] A8A22F71C7784BE7956F3ACBD2460CF9')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1293, CAST(N'2016-10-13 15:51:43.503' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1142]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P3732/D2] 22BE0F379A0D4607B55DD5DE1D45A01B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1294, CAST(N'2016-10-13 15:53:29.990' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"homePage\",\"Id\":1050,\"PropertyTypeIds\":[37,38,46,47,83,88,89],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P3732/D2] 22BE0F379A0D4607B55DD5DE1D45A01B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1295, CAST(N'2016-10-13 15:54:06.167' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1101]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P3732/D2] 22BE0F379A0D4607B55DD5DE1D45A01B')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1296, CAST(N'2016-10-13 15:56:05.557' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1075]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1075]","JsonPayload":null}]', N'ELIAS-PC//LM/W3SVC/2/ROOT [P3732/D2] 22BE0F379A0D4607B55DD5DE1D45A01B')
SET IDENTITY_INSERT [dbo].[umbracoCacheInstruction] OFF
SET IDENTITY_INSERT [dbo].[umbracoLanguage] ON 

INSERT [dbo].[umbracoLanguage] ([id], [languageISOCode], [languageCultureName]) VALUES (1, N'en-US', N'en-US')
SET IDENTITY_INSERT [dbo].[umbracoLanguage] OFF
SET IDENTITY_INSERT [dbo].[umbracoLog] ON 

INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1, 0, 1046, CAST(N'2016-09-05 08:51:01.080' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (2, 0, 1047, CAST(N'2016-09-05 08:51:28.450' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (3, 0, 1048, CAST(N'2016-09-05 08:51:36.327' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (4, 0, 1049, CAST(N'2016-09-05 08:57:09.827' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (5, 0, 1050, CAST(N'2016-09-05 08:57:10.213' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (6, 0, 1051, CAST(N'2016-09-05 09:00:15.097' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (7, 0, 1052, CAST(N'2016-09-05 09:00:15.417' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (8, 0, 1053, CAST(N'2016-09-05 09:02:01.500' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (9, 0, 1054, CAST(N'2016-09-05 09:02:13.727' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (10, 0, 1055, CAST(N'2016-09-05 09:02:15.253' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (11, 0, 1056, CAST(N'2016-09-05 09:05:31.910' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (12, 0, 1057, CAST(N'2016-09-05 09:05:40.127' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (13, 0, 1058, CAST(N'2016-09-05 09:05:41.827' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (14, 0, 1059, CAST(N'2016-09-05 09:06:23.297' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (15, 0, 1054, CAST(N'2016-09-05 09:06:52.150' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (16, 0, 1051, CAST(N'2016-09-05 09:06:59.123' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (17, 0, 1049, CAST(N'2016-09-05 09:07:06.623' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (18, 0, 1057, CAST(N'2016-09-05 09:07:14.443' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (19, 0, 1050, CAST(N'2016-09-05 09:07:32.600' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (20, 0, 1052, CAST(N'2016-09-05 09:07:43.060' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (21, 0, 1050, CAST(N'2016-09-05 09:07:53.890' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (22, 0, 1046, CAST(N'2016-09-05 09:15:28.130' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (23, 0, 1060, CAST(N'2016-09-05 09:15:38.110' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (24, 0, 1061, CAST(N'2016-09-05 09:15:46.890' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (25, 0, 1048, CAST(N'2016-09-05 09:15:53.273' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (26, 0, 1062, CAST(N'2016-09-05 09:19:22.863' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (27, 0, 1059, CAST(N'2016-09-05 09:23:14.470' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (28, 0, 1050, CAST(N'2016-09-05 09:44:54.843' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (29, 0, 1052, CAST(N'2016-09-05 09:46:16.667' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (30, 0, 1058, CAST(N'2016-09-05 09:46:53.180' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (31, 0, 1055, CAST(N'2016-09-05 09:47:21.963' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (32, 0, 1063, CAST(N'2016-09-05 09:47:49.243' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (33, 0, 1064, CAST(N'2016-09-05 09:48:43.637' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (34, 0, 1065, CAST(N'2016-09-05 09:49:04.743' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (35, 0, 1050, CAST(N'2016-09-05 09:51:14.907' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (36, 0, -1, CAST(N'2016-09-05 09:51:57.360' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (37, 0, -1, CAST(N'2016-09-05 09:51:57.433' AS DateTime), N'Save', N'Save Macro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (38, 0, -1, CAST(N'2016-09-05 09:52:54.933' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (39, 0, -1, CAST(N'2016-09-05 09:53:23.027' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (40, 0, -1, CAST(N'2016-09-05 09:53:23.047' AS DateTime), N'Save', N'Save Macro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (41, 0, -1, CAST(N'2016-09-05 09:53:32.143' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (42, 0, 1066, CAST(N'2016-09-05 10:02:52.883' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (43, 0, 1067, CAST(N'2016-09-05 10:02:53.053' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (44, 0, 1068, CAST(N'2016-09-05 10:04:38.167' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (45, 0, 1069, CAST(N'2016-09-05 10:05:07.963' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (46, 0, 1067, CAST(N'2016-09-05 10:05:12.623' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (47, 0, 1067, CAST(N'2016-09-05 10:06:48.247' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (48, 0, 1070, CAST(N'2016-09-05 10:08:20.223' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (49, 0, 1071, CAST(N'2016-09-05 10:08:20.370' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (50, 0, 1072, CAST(N'2016-09-05 10:11:44.533' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (51, 0, 1073, CAST(N'2016-09-05 10:12:09.847' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (52, 0, 1074, CAST(N'2016-09-05 10:12:33.883' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (53, 0, 1071, CAST(N'2016-09-05 10:13:00.357' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (54, 0, 1067, CAST(N'2016-09-05 10:13:15.067' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (55, 0, 1050, CAST(N'2016-09-05 10:13:33.343' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (56, 0, 1059, CAST(N'2016-09-05 10:14:45.790' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (57, 0, 1066, CAST(N'2016-09-05 10:54:17.727' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (58, 0, 1070, CAST(N'2016-09-05 10:54:27.357' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (59, 0, 1059, CAST(N'2016-09-05 10:58:54.623' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (60, 0, 1059, CAST(N'2016-09-05 10:59:04.673' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (61, 0, -1, CAST(N'2016-09-20 09:32:25.867' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (62, 0, -1, CAST(N'2016-09-20 09:39:10.910' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (63, 0, 0, CAST(N'2016-09-20 09:39:35.927' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (64, 0, 1075, CAST(N'2016-09-20 09:40:56.907' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (65, 0, 0, CAST(N'2016-09-20 09:41:27.237' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (66, 0, 1076, CAST(N'2016-09-20 09:42:23.200' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (67, 0, 0, CAST(N'2016-09-20 09:42:32.273' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (68, 0, 1077, CAST(N'2016-09-20 09:43:25.633' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (69, 0, 0, CAST(N'2016-09-20 09:43:39.870' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (70, 0, 1078, CAST(N'2016-09-20 09:45:01.760' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (71, 0, 1078, CAST(N'2016-09-20 09:46:51.933' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (72, 0, 0, CAST(N'2016-09-20 09:47:14.877' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (73, 0, 1079, CAST(N'2016-09-20 09:47:59.780' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (74, 0, 0, CAST(N'2016-09-20 09:48:19.060' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (75, 0, 1080, CAST(N'2016-09-20 09:49:20.527' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (76, 0, 1080, CAST(N'2016-09-20 09:49:41.990' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (77, 0, 0, CAST(N'2016-09-20 09:49:48.573' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (78, 0, 1081, CAST(N'2016-09-20 09:50:32.303' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (79, 0, 1066, CAST(N'2016-09-20 09:51:07.753' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (80, 0, -1, CAST(N'2016-09-20 10:06:42.810' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (81, 0, 1084, CAST(N'2016-09-26 09:23:57.190' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (82, 0, 1085, CAST(N'2016-09-26 09:25:23.107' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (83, 0, 1086, CAST(N'2016-09-26 09:25:53.140' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (84, 0, -1, CAST(N'2016-09-26 09:41:44.487' AS DateTime), N'Save', N'Save PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (85, 0, -1, CAST(N'2016-09-26 09:41:45.233' AS DateTime), N'Save', N'Save Macro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (86, 0, -1, CAST(N'2016-09-26 09:42:20.153' AS DateTime), N'Save', N'Save Macro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (87, 0, 1091, CAST(N'2016-09-26 09:45:20.060' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (88, 0, 1091, CAST(N'2016-09-26 09:45:30.960' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (89, 0, 1091, CAST(N'2016-09-26 09:45:32.600' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (90, 0, 1058, CAST(N'2016-09-26 09:45:48.830' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (91, 0, 0, CAST(N'2016-09-26 09:46:54.777' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (92, 0, 1092, CAST(N'2016-09-26 09:47:44.890' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (93, 0, 0, CAST(N'2016-09-26 09:48:27.913' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (94, 0, 1093, CAST(N'2016-09-26 09:49:07.937' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (95, 0, 0, CAST(N'2016-09-26 10:21:28.580' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (96, 0, 1094, CAST(N'2016-09-26 10:22:06.790' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (97, 0, -1, CAST(N'2016-09-26 10:25:28.707' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (98, 0, 1091, CAST(N'2016-09-26 10:26:50.650' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (99, 0, 1095, CAST(N'2016-09-26 10:46:40.543' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (100, 0, 1048, CAST(N'2016-09-26 10:47:48.397' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (101, 0, 1094, CAST(N'2016-09-26 10:48:23.613' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (102, 0, 1095, CAST(N'2016-09-26 10:51:15.803' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (103, 0, 1048, CAST(N'2016-09-26 10:52:05.863' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (104, 0, 1094, CAST(N'2016-09-26 10:52:28.527' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (105, 0, 1096, CAST(N'2016-09-26 10:53:38.900' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (106, 0, -1, CAST(N'2016-09-26 10:54:04.800' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (107, 0, 1048, CAST(N'2016-09-26 10:54:05.047' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (108, 0, -1, CAST(N'2016-09-26 10:56:06.913' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (109, 0, 1048, CAST(N'2016-09-26 10:56:07.420' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (110, 0, 1094, CAST(N'2016-09-26 10:56:41.867' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (111, 0, 1091, CAST(N'2016-09-26 10:58:27.403' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (112, 0, -1, CAST(N'2016-09-26 11:06:41.367' AS DateTime), N'Delete', N'Delete PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (113, 0, -1, CAST(N'2016-09-26 11:06:46.397' AS DateTime), N'Delete', N'Delete PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (114, 0, -1, CAST(N'2016-09-26 11:06:49.863' AS DateTime), N'Delete', N'Delete PartialViewMacro performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (115, 0, 1059, CAST(N'2016-09-26 11:07:51.273' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (116, 0, -1, CAST(N'2016-09-26 11:10:28.150' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (117, 0, 1059, CAST(N'2016-09-26 11:36:15.530' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (118, 0, -1, CAST(N'2016-09-26 11:47:14.093' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (119, 0, 1097, CAST(N'2016-09-26 11:57:26.393' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (120, 0, 1098, CAST(N'2016-09-26 11:57:26.837' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (121, 0, 1097, CAST(N'2016-09-26 11:57:58.487' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (122, 0, 1097, CAST(N'2016-09-26 11:58:32.497' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (123, 0, 1097, CAST(N'2016-09-26 11:59:37.217' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (124, 0, 1050, CAST(N'2016-09-26 12:00:29.557' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (125, 0, 0, CAST(N'2016-09-26 12:00:49.640' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (126, 0, 1099, CAST(N'2016-09-26 12:01:31.430' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (127, 0, -1, CAST(N'2016-10-10 09:27:15.643' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (128, 0, -1, CAST(N'2016-10-10 09:32:33.210' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (129, 0, 1059, CAST(N'2016-10-10 09:33:56.310' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (130, 0, 1066, CAST(N'2016-10-10 09:34:49.363' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (131, 0, 1051, CAST(N'2016-10-10 09:34:57.733' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (132, 0, 1097, CAST(N'2016-10-10 09:35:06.977' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (133, 0, 1049, CAST(N'2016-10-10 09:35:12.713' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (134, 0, 1091, CAST(N'2016-10-10 09:35:22.090' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (135, 0, 1070, CAST(N'2016-10-10 09:35:30.667' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (136, 0, 1066, CAST(N'2016-10-10 09:35:39.440' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (137, 0, 1057, CAST(N'2016-10-10 09:35:45.183' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (138, 0, 1057, CAST(N'2016-10-10 09:37:38.297' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (139, 0, 1070, CAST(N'2016-10-10 09:37:42.963' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (140, 0, 1066, CAST(N'2016-10-10 09:37:49.613' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (141, 0, 1091, CAST(N'2016-10-10 09:37:54.863' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (142, 0, 1049, CAST(N'2016-10-10 09:38:02.930' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (143, 0, 1097, CAST(N'2016-10-10 09:38:08.217' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (144, 0, 1051, CAST(N'2016-10-10 09:38:12.863' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (145, 0, 1054, CAST(N'2016-10-10 09:38:17.550' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (146, 0, 1059, CAST(N'2016-10-10 09:38:21.353' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (147, 0, 1100, CAST(N'2016-10-10 09:38:37.807' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (148, 0, 1101, CAST(N'2016-10-10 09:41:04.030' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (149, 0, 1101, CAST(N'2016-10-10 09:41:16.837' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (150, 0, 1050, CAST(N'2016-10-10 09:41:39.797' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (151, 0, 1102, CAST(N'2016-10-10 09:41:56.527' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (152, 0, 1103, CAST(N'2016-10-10 09:42:18.020' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (153, 0, 1104, CAST(N'2016-10-10 09:42:32.447' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (154, 0, 1105, CAST(N'2016-10-10 09:42:46.300' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (155, 0, 1106, CAST(N'2016-10-10 09:42:56.990' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (156, 0, 1075, CAST(N'2016-10-10 10:11:23.430' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (157, 0, 1050, CAST(N'2016-10-10 10:12:36.727' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (158, 0, 1101, CAST(N'2016-10-10 10:22:22.110' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (159, 0, 1101, CAST(N'2016-10-10 10:22:31.373' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (160, 0, 1080, CAST(N'2016-10-10 10:49:37.530' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (161, 0, -1, CAST(N'2016-10-10 10:50:06.347' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (162, 0, -1, CAST(N'2016-10-10 10:50:55.107' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (163, 0, -1, CAST(N'2016-10-10 10:51:21.580' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (164, 0, -1, CAST(N'2016-10-10 10:51:43.630' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (165, 0, -1, CAST(N'2016-10-10 11:02:22.910' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (166, 0, 1107, CAST(N'2016-10-10 11:14:55.647' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (167, 0, 1098, CAST(N'2016-10-10 11:15:36.967' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (168, 0, 1098, CAST(N'2016-10-10 11:17:30.877' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (169, 0, 0, CAST(N'2016-10-10 11:20:57.703' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (170, 0, 1108, CAST(N'2016-10-10 11:21:54.993' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (171, 0, 1058, CAST(N'2016-10-10 11:22:37.693' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (172, 0, 1109, CAST(N'2016-10-10 11:24:21.537' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (173, 0, 1110, CAST(N'2016-10-10 11:24:23.340' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (174, 0, 1111, CAST(N'2016-10-10 11:25:38.033' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (175, 0, 1111, CAST(N'2016-10-10 11:25:49.390' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (176, 0, 1111, CAST(N'2016-10-10 11:25:49.493' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (177, 0, 1058, CAST(N'2016-10-10 11:26:27.573' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (178, 0, 1099, CAST(N'2016-10-10 11:26:44.867' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (179, 0, 1099, CAST(N'2016-10-10 11:26:45.890' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (180, 0, -1, CAST(N'2016-10-10 11:26:45.897' AS DateTime), N'Delete', N'Delete Content of Type 1098 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (181, 0, 1098, CAST(N'2016-10-10 11:26:46.957' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (182, 0, 1109, CAST(N'2016-10-10 11:27:03.423' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (183, 0, 1107, CAST(N'2016-10-10 11:27:38.150' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (184, 0, 1108, CAST(N'2016-10-10 11:28:28.827' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (185, 0, 1050, CAST(N'2016-10-10 11:29:10.720' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (186, 0, 0, CAST(N'2016-10-10 11:29:20.583' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (187, 0, 1112, CAST(N'2016-10-10 11:30:02.123' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (188, 0, 1113, CAST(N'2016-10-10 15:27:45.107' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (189, 0, 1113, CAST(N'2016-10-10 15:29:16.927' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (190, 0, 1113, CAST(N'2016-10-10 15:29:53.867' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (191, 0, 1058, CAST(N'2016-10-10 15:30:16.597' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (192, 0, 1104, CAST(N'2016-10-10 15:33:33.333' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (193, 0, -1, CAST(N'2016-10-10 15:41:36.103' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (194, 0, -1, CAST(N'2016-10-10 15:49:32.703' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (195, 0, 1114, CAST(N'2016-10-10 15:51:48.677' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (196, 0, 1115, CAST(N'2016-10-10 15:52:35.777' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (197, 0, 1116, CAST(N'2016-10-10 15:55:51.913' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (198, 0, 1117, CAST(N'2016-10-10 15:55:57.737' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (199, 0, 1118, CAST(N'2016-10-10 15:55:59.067' AS DateTime), N'Save', N'Save ContentType performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (200, 0, -1, CAST(N'2016-10-10 15:58:21.883' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (201, 0, -1, CAST(N'2016-10-10 15:59:29.193' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (202, 0, 1117, CAST(N'2016-10-11 18:05:59.417' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (203, 0, 1117, CAST(N'2016-10-11 18:06:05.237' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (204, 0, 1050, CAST(N'2016-10-11 20:11:58.690' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (205, 0, 1076, CAST(N'2016-10-11 20:12:49.160' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (206, 0, 1093, CAST(N'2016-10-11 20:12:49.247' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (207, 0, 1079, CAST(N'2016-10-11 20:12:49.283' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (208, 0, 1078, CAST(N'2016-10-11 20:12:49.310' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (209, 0, 1076, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'Delete', N'Trashed content with Id: ''1076'' related to original parent content with Id: ''1075''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (210, 0, 1093, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'Delete', N'Trashed content with Id: ''1093'' related to original parent content with Id: ''1076''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (211, 0, 1079, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'Delete', N'Trashed content with Id: ''1079'' related to original parent content with Id: ''1076''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (212, 0, 1078, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'Delete', N'Trashed content with Id: ''1078'' related to original parent content with Id: ''1076''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (213, 0, 1076, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (214, 0, 1077, CAST(N'2016-10-11 20:12:54.323' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (215, 0, 1080, CAST(N'2016-10-11 20:12:54.353' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (216, 0, 1081, CAST(N'2016-10-11 20:12:54.373' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (217, 0, 1077, CAST(N'2016-10-11 20:12:54.393' AS DateTime), N'Delete', N'Trashed content with Id: ''1077'' related to original parent content with Id: ''1075''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (218, 0, 1080, CAST(N'2016-10-11 20:12:54.397' AS DateTime), N'Delete', N'Trashed content with Id: ''1080'' related to original parent content with Id: ''1077''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (219, 0, 1081, CAST(N'2016-10-11 20:12:54.400' AS DateTime), N'Delete', N'Trashed content with Id: ''1081'' related to original parent content with Id: ''1077''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (220, 0, 1077, CAST(N'2016-10-11 20:12:54.400' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (221, 0, 0, CAST(N'2016-10-11 20:13:06.803' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (222, 0, 1119, CAST(N'2016-10-11 20:14:05.697' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (223, 0, 0, CAST(N'2016-10-11 20:14:26.430' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (224, 0, 1120, CAST(N'2016-10-11 20:15:05.660' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (225, 0, 1120, CAST(N'2016-10-11 20:15:47.110' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (226, 0, 0, CAST(N'2016-10-11 20:15:49.673' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (227, 0, 1121, CAST(N'2016-10-11 20:16:21.597' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (228, 0, 0, CAST(N'2016-10-11 20:16:25.083' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (229, 0, 1122, CAST(N'2016-10-11 20:16:52.043' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (230, 0, 0, CAST(N'2016-10-11 20:16:54.833' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (231, 0, 1123, CAST(N'2016-10-11 20:17:32.360' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (232, 0, 1123, CAST(N'2016-10-11 20:17:45.403' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (233, 0, 0, CAST(N'2016-10-11 20:17:48.553' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (234, 0, 1124, CAST(N'2016-10-11 20:18:26.400' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (235, 0, 1067, CAST(N'2016-10-11 20:21:56.550' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (236, 0, 1071, CAST(N'2016-10-11 20:22:05.997' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (237, 0, 1052, CAST(N'2016-10-11 20:22:18.923' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (238, 0, 1055, CAST(N'2016-10-11 20:22:25.487' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (239, 0, 1118, CAST(N'2016-10-11 20:22:42.883' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (240, 0, 1118, CAST(N'2016-10-11 20:24:25.073' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (241, 0, 1125, CAST(N'2016-10-11 20:25:36.753' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (242, 0, 1126, CAST(N'2016-10-11 20:25:36.807' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (243, 0, 1117, CAST(N'2016-10-11 20:25:52.940' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (244, 0, 1117, CAST(N'2016-10-11 20:26:20.413' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (245, 0, 1125, CAST(N'2016-10-11 20:26:46.390' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (246, 0, 1126, CAST(N'2016-10-11 20:27:02.813' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (247, 0, 1125, CAST(N'2016-10-11 20:27:23.017' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (248, 0, 1126, CAST(N'2016-10-11 20:27:38.773' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (249, 0, 1058, CAST(N'2016-10-11 21:48:16.477' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (250, 0, 1092, CAST(N'2016-10-11 21:48:30.357' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (251, 0, 1094, CAST(N'2016-10-11 21:48:37.787' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (252, 0, 1108, CAST(N'2016-10-11 21:48:44.443' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (253, 0, 1112, CAST(N'2016-10-11 21:48:49.433' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (254, 0, 1121, CAST(N'2016-10-11 21:48:57.767' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (255, 0, 1122, CAST(N'2016-10-11 21:49:03.643' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (256, 0, 1119, CAST(N'2016-10-11 21:49:09.100' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (257, 0, 1120, CAST(N'2016-10-11 21:49:21.727' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (258, 0, 1123, CAST(N'2016-10-11 21:49:28.320' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (259, 0, 1124, CAST(N'2016-10-11 21:49:35.987' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (260, 0, 1104, CAST(N'2016-10-11 21:51:29.723' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (261, 0, 1104, CAST(N'2016-10-11 21:51:55.253' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (262, 0, 1105, CAST(N'2016-10-11 21:52:36.397' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (263, 0, -1, CAST(N'2016-10-12 03:11:36.480' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (264, 0, 1092, CAST(N'2016-10-12 03:26:12.063' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (265, 0, 1123, CAST(N'2016-10-12 03:30:38.707' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (266, 0, 1123, CAST(N'2016-10-12 03:30:55.723' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (267, 0, -1, CAST(N'2016-10-12 03:45:07.207' AS DateTime), N'Delete', N'Delete PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (268, 0, -1, CAST(N'2016-10-12 03:45:23.763' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (269, 0, 1120, CAST(N'2016-10-12 04:00:31.503' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (270, 0, 1120, CAST(N'2016-10-12 04:01:03.167' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (271, 0, 1120, CAST(N'2016-10-12 04:01:34.983' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (272, 0, 1092, CAST(N'2016-10-12 04:10:55.450' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (273, 0, 1121, CAST(N'2016-10-12 11:52:26.903' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (274, 0, 0, CAST(N'2016-10-12 12:05:45.693' AS DateTime), N'New', N'Media ''Angular-2-features.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (275, 0, 1127, CAST(N'2016-10-12 12:05:45.830' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (276, 0, 1121, CAST(N'2016-10-12 12:05:55.543' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (277, 0, 1055, CAST(N'2016-10-12 12:07:36.570' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (278, 0, 1105, CAST(N'2016-10-12 12:09:04.413' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (279, 0, 1128, CAST(N'2016-10-12 12:09:43.023' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (280, 0, 1055, CAST(N'2016-10-12 12:09:49.757' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (281, 0, 1121, CAST(N'2016-10-12 12:10:27.560' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (282, 0, 1121, CAST(N'2016-10-12 12:10:53.033' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (283, 0, 1121, CAST(N'2016-10-12 12:14:48.463' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (284, 0, 1105, CAST(N'2016-10-12 12:16:51.093' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (285, 0, 1043, CAST(N'2016-10-12 12:22:11.133' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (286, 0, 1121, CAST(N'2016-10-12 12:23:02.590' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (287, 0, 1043, CAST(N'2016-10-12 12:23:30.520' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (288, 0, 1121, CAST(N'2016-10-12 12:23:49.803' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (289, 0, 1043, CAST(N'2016-10-12 12:25:58.017' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (290, 0, 1121, CAST(N'2016-10-12 12:26:32.807' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (291, 0, 1043, CAST(N'2016-10-12 12:27:19.067' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (292, 0, 1121, CAST(N'2016-10-12 12:31:02.490' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1292, 0, 1107, CAST(N'2016-10-12 14:16:08.653' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1293, 0, 1112, CAST(N'2016-10-12 14:22:21.857' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1294, 0, 1112, CAST(N'2016-10-12 14:22:26.130' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1295, 0, 1112, CAST(N'2016-10-12 14:28:02.147' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1296, 0, 1120, CAST(N'2016-10-12 14:39:12.430' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1297, 0, 1129, CAST(N'2016-10-12 14:39:50.880' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1298, 0, 1071, CAST(N'2016-10-12 14:39:54.793' AS DateTime), N'Save', N'Save ContentType performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1299, 0, 1050, CAST(N'2016-10-12 16:36:30.713' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1300, 0, 1126, CAST(N'2016-10-12 16:36:36.917' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1301, 0, 1126, CAST(N'2016-10-12 16:37:17.380' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1302, 0, 0, CAST(N'2016-10-12 16:37:23.787' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1303, 0, 1126, CAST(N'2016-10-12 16:38:07.823' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1304, 0, 1125, CAST(N'2016-10-12 16:38:47.003' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1305, 0, 1125, CAST(N'2016-10-12 16:38:51.263' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1306, 0, 1125, CAST(N'2016-10-12 16:39:07.920' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1307, 0, 1125, CAST(N'2016-10-12 16:39:31.200' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1308, 0, 0, CAST(N'2016-10-12 16:39:56.257' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1309, 0, 1130, CAST(N'2016-10-12 16:40:13.213' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1310, 0, 0, CAST(N'2016-10-12 16:40:22.947' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1311, 0, 1131, CAST(N'2016-10-12 16:41:32.093' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1312, 0, 1130, CAST(N'2016-10-13 13:12:39.007' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1313, 0, 1131, CAST(N'2016-10-13 13:12:39.183' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1314, 0, 1130, CAST(N'2016-10-13 13:12:39.257' AS DateTime), N'Delete', N'Trashed content with Id: ''1130'' related to original parent content with Id: ''1075''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1315, 0, 1131, CAST(N'2016-10-13 13:12:39.257' AS DateTime), N'Delete', N'Trashed content with Id: ''1131'' related to original parent content with Id: ''1130''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1316, 0, 1130, CAST(N'2016-10-13 13:12:39.260' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1317, 0, 0, CAST(N'2016-10-13 13:12:57.410' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1318, 0, 1125, CAST(N'2016-10-13 13:13:32.273' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1319, 0, 1132, CAST(N'2016-10-13 13:13:43.900' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1320, 0, 1132, CAST(N'2016-10-13 13:13:53.080' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1321, 0, 1118, CAST(N'2016-10-13 13:14:10.290' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1322, 0, 0, CAST(N'2016-10-13 13:14:18.920' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1323, 0, 1133, CAST(N'2016-10-13 13:14:40.920' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1324, 0, 1132, CAST(N'2016-10-13 13:15:22.090' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1325, 0, 1126, CAST(N'2016-10-13 13:15:34.203' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1326, 0, 1133, CAST(N'2016-10-13 13:15:48.590' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1327, 0, 0, CAST(N'2016-10-13 13:36:44.000' AS DateTime), N'New', N'Content ''Angular is back'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1328, 0, 0, CAST(N'2016-10-13 13:38:47.980' AS DateTime), N'New', N'Content ''Angular is back'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1329, 0, -1, CAST(N'2016-10-13 13:39:17.680' AS DateTime), N'Publish', N'ContentService.RebuildXmlStructures completed, the xml has been regenerated in the database')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1330, 0, 1118, CAST(N'2016-10-13 13:39:17.720' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1331, 0, 1126, CAST(N'2016-10-13 13:40:01.100' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1332, 0, 0, CAST(N'2016-10-13 13:40:09.077' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1333, 0, 0, CAST(N'2016-10-13 15:05:33.947' AS DateTime), N'New', N'Content ''Angular is back'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1334, 0, 0, CAST(N'2016-10-13 15:06:27.127' AS DateTime), N'New', N'Content ''Angular is back'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1335, 0, 0, CAST(N'2016-10-13 15:22:51.077' AS DateTime), N'New', N'Content ''Angular is back'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1336, 0, 1134, CAST(N'2016-10-13 15:22:51.327' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1337, 0, 1075, CAST(N'2016-10-13 15:43:33.800' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1338, 0, 1094, CAST(N'2016-10-13 15:44:23.103' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1339, 0, 1050, CAST(N'2016-10-13 15:47:04.747' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1340, 0, 1050, CAST(N'2016-10-13 15:47:13.177' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1341, 0, 1075, CAST(N'2016-10-13 15:47:56.763' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1342, 0, 1123, CAST(N'2016-10-13 16:05:15.880' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1343, 0, 1124, CAST(N'2016-10-13 16:05:51.443' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1344, 0, 1124, CAST(N'2016-10-13 16:06:01.563' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1345, 0, 1123, CAST(N'2016-10-13 16:06:46.633' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1346, 0, 0, CAST(N'2016-10-13 16:28:20.043' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1347, 0, 1135, CAST(N'2016-10-13 16:29:34.227' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1348, 0, 1136, CAST(N'2016-10-13 16:38:46.020' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1349, 0, 1137, CAST(N'2016-10-13 16:41:05.583' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1350, 0, 1138, CAST(N'2016-10-13 16:41:05.730' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1351, 0, 1139, CAST(N'2016-10-13 17:06:35.800' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1352, 0, 1137, CAST(N'2016-10-13 17:06:55.203' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1353, 0, 1140, CAST(N'2016-10-13 17:07:21.403' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1354, 0, 1140, CAST(N'2016-10-13 17:07:25.710' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1355, 0, 1139, CAST(N'2016-10-13 17:07:39.633' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1356, 0, -1, CAST(N'2016-10-13 17:08:11.003' AS DateTime), N'Save', N'Save PartialView performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1357, 0, 1050, CAST(N'2016-10-13 17:38:32.360' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1358, 0, 0, CAST(N'2016-10-13 17:38:38.817' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1359, 0, 1139, CAST(N'2016-10-13 17:39:21.873' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1360, 0, 0, CAST(N'2016-10-13 17:39:31.533' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1361, 0, 1141, CAST(N'2016-10-13 17:39:39.913' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1362, 0, 1142, CAST(N'2016-10-13 17:47:29.287' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1363, 0, 1142, CAST(N'2016-10-13 17:47:40.693' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1364, 0, 1058, CAST(N'2016-10-13 17:47:51.903' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1365, 0, 1094, CAST(N'2016-10-13 17:48:09.380' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1366, 0, 1142, CAST(N'2016-10-13 17:51:43.493' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1367, 0, 1050, CAST(N'2016-10-13 17:53:29.923' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1368, 0, 1101, CAST(N'2016-10-13 17:54:06.163' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1369, 0, 1075, CAST(N'2016-10-13 17:56:05.540' AS DateTime), N'Publish', N'Save and Publish performed by user')
SET IDENTITY_INSERT [dbo].[umbracoLog] OFF
SET IDENTITY_INSERT [dbo].[umbracoMigration] ON 

INSERT [dbo].[umbracoMigration] ([id], [name], [createDate], [version]) VALUES (1, N'Umbraco', CAST(N'2016-09-05 08:47:13.090' AS DateTime), N'7.5.2')
INSERT [dbo].[umbracoMigration] ([id], [name], [createDate], [version]) VALUES (2, N'Umbraco', CAST(N'2016-10-10 09:18:07.403' AS DateTime), N'7.5.3')
SET IDENTITY_INSERT [dbo].[umbracoMigration] OFF
SET IDENTITY_INSERT [dbo].[umbracoNode] ON 

INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-331, 0, -1, 0, 1, N'-1,-331', 1, N'0af5e610-a310-4b6f-925f-e928d5416af7', N'LOCK: Servers', N'87a9f1ff-b1e4-4a25-babb-465a4a47ec41', CAST(N'2016-09-05 08:47:02.200' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-97, 0, -1, 0, 1, N'-1,-97', 2, N'aa2c52a0-ce87-4e65-a47c-7df09358585d', N'List View - Members', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.053' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-96, 0, -1, 0, 1, N'-1,-96', 2, N'3a0156c4-3b8c-4803-bdc1-6871faa83fff', N'List View - Media', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.050' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-95, 0, -1, 0, 1, N'-1,-95', 2, N'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4', N'List View - Content', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.040' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-92, 0, -1, 0, 1, N'-1,-92', 35, N'f0bc4bfb-b499-40d6-ba86-058885a5178c', N'Label', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.830' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-90, 0, -1, 0, 1, N'-1,-90', 34, N'84c6b441-31df-4ffe-b67e-67d5bc3ae65a', N'Upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.843' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-89, 0, -1, 0, 1, N'-1,-89', 33, N'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3', N'Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.850' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-88, 0, -1, 0, 1, N'-1,-88', 32, N'0cc0eba1-9960-42c9-bf9b-60e150b429ae', N'Textstring', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.853' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-87, 0, -1, 0, 1, N'-1,-87', 4, N'ca90c950-0aff-4e72-b976-a30b1ac57dad', N'Richtext editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.863' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-51, 0, -1, 0, 1, N'-1,-51', 2, N'2e6d3631-066e-44b8-aec4-96f09099b2b5', N'Numeric', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.887' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-49, 0, -1, 0, 1, N'-1,-49', 2, N'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49', N'True/false', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.913' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-43, 0, -1, 0, 1, N'-1,-43', 2, N'fbaf13a8-4036-41f2-93a3-974f678c312a', N'Checkbox list', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.933' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-42, 0, -1, 0, 1, N'-1,-42', 2, N'0b6a45e7-44ba-430d-9da5-4e46060b9e03', N'Dropdown', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.953' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-41, 0, -1, 0, 1, N'-1,-41', 2, N'5046194e-4237-453c-a547-15db3a07c4e1', N'Date Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.973' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-40, 0, -1, 0, 1, N'-1,-40', 2, N'bb5f57c9-ce2b-4bb9-b697-4caca783a805', N'Radiobox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:01.997' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-39, 0, -1, 0, 1, N'-1,-39', 2, N'f38f0ac7-1d27-439c-9f3f-089cd8825a53', N'Dropdown multiple', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.017' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-37, 0, -1, 0, 1, N'-1,-37', 2, N'0225af17-b302-49cb-9176-b9f35cab9c17', N'Approved Color', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.023' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-36, 0, -1, 0, 1, N'-1,-36', 2, N'e4d66c0f-b935-4200-81f0-025f7256b89a', N'Date Picker with time', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.037' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-21, 0, -1, 0, 0, N'-1,-21', 0, N'bf7c7cbc-952f-4518-97a2-69e9c7b33842', N'Recycle Bin', N'cf3d8e34-1c1c-41e9-ae56-878b57b32113', CAST(N'2016-09-05 08:47:01.820' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-20, 0, -1, 0, 0, N'-1,-20', 0, N'0f582a79-1e41-4cf0-bfa0-76340651891a', N'Recycle Bin', N'01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8', CAST(N'2016-09-05 08:47:01.807' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-1, 0, -1, 0, 0, N'-1', 0, N'916724a5-173d-4619-b97e-b9de133dd6f5', N'SYSTEM DATA: umbraco master root', N'ea7d8624-4cfe-4578-a871-24aa946bf34d', CAST(N'2016-09-05 08:47:01.767' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1031, 0, -1, 0, 1, N'-1,1031', 2, N'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d', N'Folder', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2016-09-05 08:47:02.057' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1032, 0, -1, 0, 1, N'-1,1032', 2, N'cc07b313-0843-4aa8-bbda-871c8da728c8', N'Image', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2016-09-05 08:47:02.067' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1033, 0, -1, 0, 1, N'-1,1033', 2, N'4c52d8ab-54e6-40cd-999c-7a5f24903e4d', N'File', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2016-09-05 08:47:02.073' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1034, 0, -1, 0, 1, N'-1,1034', 2, N'a6857c73-d6e9-480c-b6e6-f15f6ad11125', N'Content Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.073' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1035, 0, -1, 0, 1, N'-1,1035', 2, N'93929b9a-93a2-4e2a-b239-d99334440a59', N'Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.080' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1036, 0, -1, 0, 1, N'-1,1036', 2, N'2b24165f-9782-4aa3-b459-1de4a4d21f60', N'Member Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.083' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1040, 0, -1, 0, 1, N'-1,1040', 2, N'21e798da-e06e-4eda-a511-ed257f78d4fa', N'Related Links', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.087' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1041, 0, -1, 0, 1, N'-1,1041', 2, N'b6b73142-b9c1-4bf8-a16d-e1c23320b549', N'Tags', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.100' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1043, 0, -1, 0, 1, N'-1,1043', 2, N'1df9f033-e6d4-451f-b8d2-e0cbc50a836f', N'Image Cropper', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.113' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1044, 0, -1, 0, 1, N'-1,1044', 3, N'd59be02f-1df9-4228-aa1e-01917d806cda', N'Active', N'9b5416fb-e72f-45a9-a07b-5a9a2709ce43', CAST(N'2016-09-05 08:47:02.137' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1045, 0, -1, 0, 1, N'-1,1045', 2, N'7e3962cc-ce20-4ffc-b661-5897a894ba7e', N'Multiple Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:47:02.173' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1046, 0, -1, 0, 1, N'-1,1046', 24, N'10380b05-2a18-4a18-9269-84baa0d4bfd7', N'master - MetaDescription - TextArea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:51:00.730' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1047, 0, -1, 0, 1, N'-1,1047', 25, N'5428b125-156a-4f11-9d99-757f8e7bc5f3', N'master - MetaKeywords - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 08:51:28.357' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1048, 0, -1, 0, 1, N'-1,1048', 5, N'6a8dc682-2b25-4bde-98fa-922331150336', N'master', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 08:51:35.960' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1050, 0, 1048, 0, 2, N'-1,1048,1050', 50, N'1631080c-0a2a-4263-bc58-3c842785c813', N'HomePage', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 08:57:09.873' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1052, 0, 1048, 0, 2, N'-1,1048,1052', 30, N'95fcbfdc-68fb-473f-97eb-4183917ab05d', N'ArticleMain', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 09:00:15.183' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1053, 0, -1, 0, 1, N'-1,1053', 26, N'7f7e844a-054b-4554-9643-c067a4198fb5', N'ArticleItem - Article Picture - Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:02:01.380' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1055, 0, 1048, 0, 2, N'-1,1048,1055', 36, N'1a300ee7-d5d2-4f02-a715-b21dd9241c22', N'ArticleItem', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 09:02:14.887' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1056, 0, -1, 0, 1, N'-1,1056', 27, N'6032ad16-6204-4bcd-9caa-51e12aa7811d', N'TextPage - text page main - Rich Text Editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:05:31.807' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1058, 0, 1048, 0, 2, N'-1,1048,1058', 49, N'9b5524fe-71ff-4daa-9522-bb8579a058b8', N'TextPage', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 09:05:41.233' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1060, 0, -1, 0, 1, N'-1,1060', 28, N'05dba7be-2d4e-41ff-81bf-5c3686df4e56', N'master - MetaDescription - Textarea (1)', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:15:38.037' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1061, 0, -1, 0, 1, N'-1,1061', 29, N'366ab18d-bab5-4033-88d9-057475396e32', N'master - MetaKeywords - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:15:46.837' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1062, 0, -1, 0, 1, N'-1,1062', 30, N'9b2dd86f-5551-4ccf-b1e1-bec3c8e6a9ee', N'ProjectStatus', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:19:22.740' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1063, 0, -1, 0, 1, N'-1,1063', 31, N'5993a2f5-0446-4985-a6c9-1875c49093db', N'HomePage - Footer - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:47:49.130' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1064, 0, -1, 0, 1, N'-1,1064', 32, N'13a0c270-d93f-43ad-a8ca-89645752ea4a', N'HomePage - Logo - File upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:48:43.537' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1065, 0, -1, 0, 1, N'-1,1065', 33, N'e599bc06-35cf-42e8-8ce7-f3efc4e10920', N'HomePage - Logo - Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 09:49:04.653' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1067, 0, 1048, 0, 2, N'-1,1048,1067', 28, N'a74867dd-f4ae-4096-8e28-3afd58596180', N'Project Main', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 10:02:52.923' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1068, 0, -1, 0, 1, N'-1,1068', 34, N'f9238df2-77b7-4f93-a1d8-fd88a79457fb', N'Project Main - projects header - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 10:04:38.083' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1069, 0, -1, 0, 1, N'-1,1069', 35, N'1493f3ee-8f68-45f1-97cb-c066bd435216', N'Project Main - Projects Description - Rich Text Editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 10:05:07.887' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1071, 0, 1048, 0, 2, N'-1,1048,1071', 37, N'ce3cef70-91b4-407f-ad3e-9f850b81bc91', N'ProjectsItem', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-09-05 10:08:20.257' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1072, 0, -1, 0, 1, N'-1,1072', 36, N'9e80579d-307f-40ea-84d3-5c7045260ba3', N'ProjectsItem - Project Text - Rich Text Editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 10:11:44.433' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1073, 0, -1, 0, 1, N'-1,1073', 37, N'b445dec7-75a1-4f02-baf8-afd5c8ba2c3e', N'ProjectsItem - Project files - File upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 10:12:09.750' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1074, 0, -1, 0, 1, N'-1,1074', 38, N'e4892e0d-2ad5-400b-9e60-9f8ef8d71e05', N'ProjectsItem - projects Image - Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-05 10:12:33.787' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1075, 0, -1, 0, 1, N'-1,1075', 0, N'e091bb6f-7c49-4239-9b23-0eca81cad716', N'Site', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:40:49.340' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1076, 1, -20, 0, 1, N'-1,-20,1076', 1, N'ab154a8e-576c-47cb-b6f4-cffd45ea36e2', N'Articles', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:42:22.107' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1077, 1, -20, 0, 1, N'-1,-20,1077', 2, N'5aa11c39-f62e-4bbb-a5af-352dda551b54', N'Projects', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:43:24.850' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1078, 1, 1076, 0, 2, N'-1,-20,1076,1078', 5, N'b86c9f4c-1990-4a9b-b466-c0e0d5749c56', N'MongoDB', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:44:59.920' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1079, 1, 1076, 0, 2, N'-1,-20,1076,1079', 4, N'8ab9b575-6e79-4853-9885-77c3b0901161', N'Socket.IO', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:47:51.207' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1080, 1, 1077, 0, 2, N'-1,-20,1077,1080', 2, N'24bd3a64-e12c-4ac4-a5cb-acc462132ba5', N'Chat application', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:49:18.777' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1081, 1, 1077, 0, 2, N'-1,-20,1077,1081', 3, N'a7158215-7144-4a6f-906c-89f82fbb9a5a', N'Learning Umbraco', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-20 09:50:31.570' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1082, 0, -1, 0, 0, N'-1,1082', 0, N'caac334a-0cc9-417b-8ffa-684bd4f93e1c', N'Active', N'366e63b9-880f-4e13-a61c-98069b029728', CAST(N'2016-09-26 09:21:41.683' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1083, 0, -1, 0, 0, N'-1,1083', 0, N'06a91afa-b095-42c4-b302-28f7ffb61348', N'Prospect', N'366e63b9-880f-4e13-a61c-98069b029728', CAST(N'2016-09-26 09:22:02.080' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1084, 0, -1, 0, 1, N'-1,1084', 39, N'7b4c16e1-4ed0-4f54-b770-9258553db6c5', N'Active - First Name - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-26 09:23:56.127' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1085, 0, -1, 0, 1, N'-1,1085', 40, N'3cfcafa8-c7c3-446e-ac7f-bf59c2dc66bd', N'Active - Last Name - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-26 09:25:22.893' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1086, 0, -1, 0, 1, N'-1,1086', 41, N'c6c1fc06-e763-41b0-98e9-9129e9df568c', N'Active - Address - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-26 09:25:52.290' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1087, 0, -1, 0, 1, N'-1,1087', 2, N'f7127f71-fdf5-4805-be34-9e7d8a28e114', N'Prospect', N'9b5416fb-e72f-45a9-a07b-5a9a2709ce43', CAST(N'2016-09-26 09:30:08.637' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1088, 0, -1, 0, 1, N'-1,1088', 0, N'505ce24e-781b-4308-89b2-5cf3cebdd82a', N'Daniel', N'39eb0f98-b348-42a1-8662-e7eb18487560', CAST(N'2016-09-26 09:33:42.013' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1089, 0, -1, 0, 1, N'-1,1089', 1, N'04ff81ec-8a67-45fc-a04c-6967feb55311', N'Elias', N'39eb0f98-b348-42a1-8662-e7eb18487560', CAST(N'2016-09-26 09:38:17.110' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1090, 0, -1, 0, 1, N'-1,1090', 2, N'92ccf9aa-3f09-4ddc-b67b-ba1cca8274a5', N'Barlach', N'39eb0f98-b348-42a1-8662-e7eb18487560', CAST(N'2016-09-26 09:40:51.983' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1092, 0, 1075, 0, 2, N'-1,1075,1092', 2, N'1ff39837-1d04-4a1f-9ce3-ad081b0d64cf', N'Login', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-26 09:47:42.117' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1093, 1, 1076, 0, 2, N'-1,-20,1076,1093', 3, N'b76b368e-60f8-408c-ac50-8816d8ef697a', N'MEAN Stack', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-26 09:49:06.313' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1094, 0, 1075, 0, 2, N'-1,1075,1094', 3, N'95b0692a-1994-46e7-82cf-99e124171574', N'Forbidden Acess', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-09-26 10:22:03.007' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1095, 0, -1, 0, 1, N'-1,1095', 42, N'fff0eca8-083e-4ffc-865c-c79bb65a49f8', N'umbracoNaviHide', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-26 10:46:39.717' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1096, 0, -1, 0, 1, N'-1,1096', 43, N'10f33c37-b957-4d81-87c3-48f019be0755', N'master - Hide in Navigation - TrueFalse', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-09-26 10:53:38.757' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1100, 0, -1, NULL, 1, N'-1,1100', 0, N'26be269c-0577-4bf6-83e3-bad73200ec41', N'Master', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:38:37.547' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1101, 0, 1100, NULL, 1, N'-1,1100,1101', 0, N'ba817046-4f90-4e99-bcc6-1877dc2a5c54', N'Home', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:41:03.887' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1102, 0, 1100, NULL, 1, N'-1,1100,1102', 0, N'a613cd01-c0c1-4c86-8829-8e79ebfba2d7', N'ProjectMain', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:41:56.353' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1103, 0, 1100, NULL, 1, N'-1,1100,1103', 0, N'56475487-68ee-479e-9646-0ca651956ef7', N'ProjectItem', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:42:17.843' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1104, 0, 1100, NULL, 1, N'-1,1100,1104', 0, N'c71fd2bf-7d8c-4098-80e5-4a8e48f0ab16', N'ArticleMain', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:42:32.103' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1105, 0, 1100, NULL, 1, N'-1,1100,1105', 0, N'9ebb6495-23a8-424d-a4ff-4d143618f564', N'ArticleItem', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:42:46.203' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1106, 0, 1100, NULL, 1, N'-1,1100,1106', 0, N'6f04e6ff-e9c4-4fe7-a846-dcd645022421', N'Textpage', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 09:42:56.703' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1107, 0, -1, 0, 1, N'-1,1107', 44, N'b0196790-ce7d-4060-8d6b-ff5fdee02c2b', N'Grid AboutPage', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-10 11:14:42.213' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1108, 0, 1075, 0, 2, N'-1,1075,1108', 5, N'b600d7e3-ee5e-4f05-9781-9cfabddd753c', N'Contact Us', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-10 11:21:46.997' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1109, 0, 1100, NULL, 1, N'-1,1100,1109', 0, N'0617cd47-bcaa-4446-854d-e739b864b146', N'AboutPage', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 11:24:21.273' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1110, 0, 1048, 0, 2, N'-1,1048,1110', 7, N'0000e929-9e38-4079-91b6-60f29a7653f2', N'AboutPage', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-10-10 11:24:21.727' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1111, 0, 1100, NULL, 1, N'-1,1100,1111', 0, N'2bffae43-bf21-4fef-a1cf-0a99e7e6ad53', N'ContactPage', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 11:25:37.957' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1112, 0, 1075, 0, 2, N'-1,1075,1112', 6, N'ad5cacc4-f152-440e-8455-a8dc5d0c3042', N'About', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-10 11:30:01.787' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1113, 0, 1100, NULL, 1, N'-1,1100,1113', 0, N'ef7b8627-045e-4bff-833d-f26184690a2a', N'Login', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-10 15:27:44.810' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1114, 0, -1, 0, 1, N'-1,1114', 45, N'1706392e-b61c-46be-b57e-5540f7ca48ab', N'Date - DateTime', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-10 15:51:47.813' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1115, 0, -1, 0, 1, N'-1,1115', 46, N'953daa7b-248c-4bc1-baba-0fde4eb173d9', N'message - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-10 15:52:35.550' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1116, 0, -1, 0, 1, N'-1,1116', 47, N'3e969b58-2451-45b7-bddb-61544fd6e85c', N'BoardMessage - message - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-10 15:55:51.730' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1118, 0, -1, 0, 1, N'-1,1118', 9, N'eb41acd1-992a-4288-8513-6a1c53bb2b2a', N'BoardMessage', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-10-10 15:55:58.773' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1119, 0, 1075, 0, 2, N'-1,1075,1119', 7, N'f2ff3436-9469-4ba6-8fd3-6aa396e29f08', N'Articles', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-11 20:14:05.620' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1120, 0, 1075, 0, 2, N'-1,1075,1120', 8, N'f8f06a98-7e88-4615-bee4-369072d98d20', N'Projects', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-11 20:15:05.613' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1121, 0, 1119, 0, 3, N'-1,1075,1119,1121', 0, N'5a15946a-5541-44f1-a66b-1721565e50f8', N'Angular 2', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-11 20:16:21.560' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1122, 0, 1119, 0, 3, N'-1,1075,1119,1122', 1, N'12f925b4-4fdb-4b5d-9f6d-5a576cad4ef2', N'NodeJS', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-11 20:16:51.987' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1123, 0, 1120, 0, 3, N'-1,1075,1120,1123', 0, N'30f52ed6-fac9-4e15-aec4-14eae99e7635', N'Umbraco mandatory', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-11 20:17:32.320' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1124, 0, 1120, 0, 3, N'-1,1075,1120,1124', 1, N'7f9f0597-32b7-438b-8ceb-41d57d77b1bf', N'Android shoppinglist', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-11 20:18:26.347' AS DateTime))
GO
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1126, 0, 1048, 0, 2, N'-1,1048,1126', 43, N'6906ce51-d8cb-48ab-ab3f-5389ec8c1f3d', N'MessageBoard', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-10-11 20:25:36.770' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1127, 0, -1, 0, 1, N'-1,1127', 0, N'33427bf8-2b83-43ce-a52b-374dc818c0ec', N'Angular-2-features.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2016-10-12 12:05:45.770' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1128, 0, -1, 0, 1, N'-1,1128', 48, N'2fb39aef-9f01-4f12-babc-b3b27f447622', N'ArticleItem - preview - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-12 12:09:42.990' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1129, 0, -1, 0, 1, N'-1,1129', 49, N'b09e00f1-c2f0-4aa2-8d37-204fcc60d3b6', N'ProjectsItem - preview - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-12 14:39:50.807' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1130, 1, -20, 0, 1, N'-1,-20,1130', 3, N'6482b22f-f290-4a03-8c16-11156c7b7327', N'Messageboard', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-12 16:40:13.070' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1131, 1, 1130, 0, 2, N'-1,-20,1130,1131', 1, N'b2a4ffd1-f0d4-4f7f-b3bc-80b5355ab909', N'Angular', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-12 16:41:31.987' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1132, 0, 1100, NULL, 1, N'-1,1100,1132', 0, N'e47aaece-99ca-4937-968c-48bd295dd227', N'MessageBoard', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-13 13:13:43.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1133, 0, 1075, 0, 2, N'-1,1075,1133', 9, N'b30049d5-eb25-4c2a-9b37-1836c658421f', N'MessageBoard', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-13 13:14:40.837' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1134, 0, 1133, 0, 3, N'-1,1075,1133,1134', 0, N'd01aabaa-b578-4325-8105-3d2cf309017d', N'Angular is back', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-13 15:22:51.110' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1135, 0, 1120, 0, 3, N'-1,1075,1120,1135', 2, N'0eae9b80-5d00-45d3-b93b-9dc46b6a7feb', N'M.E.A.N Stack solution', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-13 16:29:34.073' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1136, 0, -1, 0, 1, N'-1,1136', 50, N'34edf175-65c4-4906-a718-d0265d0269c8', N'ContactForm - Email - Email address', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2016-10-13 16:38:45.977' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1138, 0, -1, 0, 1, N'-1,1138', 2, N'22d7aa31-2fa8-46a4-bbf2-375817901616', N'ContactForm', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-10-13 16:41:05.677' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1139, 0, 1048, 0, 2, N'-1,1048,1139', 48, N'091462c0-eada-45d3-9905-051f9aa3c1f1', N'MemberView', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2016-10-13 17:06:35.713' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1140, 0, 1100, NULL, 1, N'-1,1100,1140', 0, N'7675d7f3-b679-4bed-91c0-28825c0d5fa1', N'MemberView', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-13 17:07:21.380' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1141, 0, 1075, 0, 2, N'-1,1075,1141', 10, N'79a1196e-b387-4317-b74f-b9e55d440f6e', N'Members', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2016-10-13 17:39:39.750' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1142, 0, 1100, NULL, 1, N'-1,1100,1142', 0, N'd82c3aef-6f62-4e7f-b419-63f8b1a5b01a', N'ForbiddenAcces', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2016-10-13 17:47:29.267' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoNode] OFF
INSERT [dbo].[umbracoRedirectUrl] ([id], [contentKey], [createDateUtc], [url], [urlHash]) VALUES (N'59891448-78b6-443b-b522-2b67d657d6dc', N'b600d7e3-ee5e-4f05-9781-9cfabddd753c', CAST(N'2016-10-10 09:28:28.490' AS DateTime), N'/about-us', N'0af561420591d14d8f459e5c505aa610aeb43e83')
SET IDENTITY_INSERT [dbo].[umbracoRelation] ON 

INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (1, 1075, 1076, 2, CAST(N'2016-10-11 20:12:49.367' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (2, 1076, 1093, 2, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (3, 1076, 1079, 2, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (4, 1076, 1078, 2, CAST(N'2016-10-11 20:12:49.370' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (5, 1075, 1077, 2, CAST(N'2016-10-11 20:12:54.393' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (6, 1077, 1080, 2, CAST(N'2016-10-11 20:12:54.393' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (7, 1077, 1081, 2, CAST(N'2016-10-11 20:12:54.400' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (8, 1075, 1130, 2, CAST(N'2016-10-13 13:12:39.247' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (9, 1130, 1131, 2, CAST(N'2016-10-13 13:12:39.257' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[umbracoRelation] OFF
SET IDENTITY_INSERT [dbo].[umbracoRelationType] ON 

INSERT [dbo].[umbracoRelationType] ([id], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (1, 1, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Document On Copy', N'relateDocumentOnCopy')
INSERT [dbo].[umbracoRelationType] ([id], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (2, 0, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Parent Document On Delete', N'relateParentDocumentOnDelete')
SET IDENTITY_INSERT [dbo].[umbracoRelationType] OFF
SET IDENTITY_INSERT [dbo].[umbracoServer] ON 

INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (1, N'http://localhost:64608/umbraco', N'LAPTOP-TDIF8TB0//LM/W3SVC/2/ROOT', CAST(N'2016-09-05 08:48:39.033' AS DateTime), CAST(N'2016-10-10 15:58:41.517' AS DateTime), 0, 0)
INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (2, N'http://localhost:64608/umbraco', N'ELIAS-PC//LM/W3SVC/2/ROOT', CAST(N'2016-10-11 18:04:46.647' AS DateTime), CAST(N'2016-10-13 17:57:49.640' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[umbracoServer] OFF
SET IDENTITY_INSERT [dbo].[umbracoUser] ON 

INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (0, 0, 0, 1, -1, -1, N'elias', N'elias.v.hansen@gmail.com', N'8C3rM7HzGRwGqAqGzvPMP47XYi0=', N'elias.v.hansen@gmail.com', N'en-GB', N'7231bbae-1074-4fb8-97d2-1e5b4b5063ff', 0, NULL, CAST(N'2016-09-05 08:47:16.123' AS DateTime), CAST(N'2016-10-13 17:27:29.260' AS DateTime))
INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (1, 0, 0, 3, -1, -1, N'Barlach', N'Barlach', N'TyvAq0hAf2g0DND+HR2udN5neVI=', N'barlach@voss.com', N'da', N'f23b6009-cb3d-4078-be22-979a872ae681', 0, NULL, CAST(N'2016-09-26 09:05:54.757' AS DateTime), CAST(N'2016-09-26 09:05:54.757' AS DateTime))
INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (2, 0, 0, 2, 1076, -1, N'Daniel', N'Daniel', N'aOSeE3UIwkkcRfkk9KP9hAaNtK8=', N'daniel@musik.com', N'en', N'1088fba1-dec8-4bb3-a9b4-d7353407e89f', 0, NULL, CAST(N'2016-09-26 09:10:40.390' AS DateTime), CAST(N'2016-09-26 09:11:14.927' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoUser] OFF
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'developer')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'forms')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'media')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'member')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'settings')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'users')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'media')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (2, N'content')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1076, N'A')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1076, N'C')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1076, N'F')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1076, N'H')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1093, N'A')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1093, N'C')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1093, N'F')
INSERT [dbo].[umbracoUser2NodePermission] ([userId], [nodeId], [permission]) VALUES (2, 1093, N'H')
SET IDENTITY_INSERT [dbo].[umbracoUserType] ON 

INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (1, N'admin', N'Administrators', N'CADMOSKTPIURZ:5F7')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (2, N'writer', N'Writer', N'CAH:F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (3, N'editor', N'Editors', N'CADMOSKTPUZ:5F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (4, N'translator', N'Translator', N'AF')
SET IDENTITY_INSERT [dbo].[umbracoUserType] OFF
/****** Object:  Index [IX_cmsContent]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContent] ON [dbo].[cmsContent]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentType]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentType] ON [dbo].[cmsContentType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsContentType_icon]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentType_icon] ON [dbo].[cmsContentType]
(
	[icon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_ContentId]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentVersion_ContentId] ON [dbo].[cmsContentVersion]
(
	[ContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_VersionId]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentVersion_VersionId] ON [dbo].[cmsContentVersion]
(
	[VersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDataType_nodeId]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDataType_nodeId] ON [dbo].[cmsDataType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDictionary_id]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDictionary_id] ON [dbo].[cmsDictionary]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDocument] ON [dbo].[cmsDocument]
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_newest]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_newest] ON [dbo].[cmsDocument]
(
	[newest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_published]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_published] ON [dbo].[cmsDocument]
(
	[published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroPropertyAlias]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroPropertyAlias] ON [dbo].[cmsMacro]
(
	[macroAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroProperty_Alias]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroProperty_Alias] ON [dbo].[cmsMacroProperty]
(
	[macro] ASC,
	[macroPropertyAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData] ON [dbo].[cmsPropertyData]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_1]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyData_1] ON [dbo].[cmsPropertyData]
(
	[contentNodeId] ASC,
	[versionId] ASC,
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_2]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_2] ON [dbo].[cmsPropertyData]
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_3]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_3] ON [dbo].[cmsPropertyData]
(
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeUniqueID]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeUniqueID] ON [dbo].[cmsPropertyType]
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeGroupUniqueID]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeGroupUniqueID] ON [dbo].[cmsPropertyTypeGroup]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTags]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsTags] ON [dbo].[cmsTags]
(
	[tag] ASC,
	[group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTaskType_alias]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_cmsTaskType_alias] ON [dbo].[cmsTaskType]
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsTemplate_nodeId]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsTemplate_nodeId] ON [dbo].[cmsTemplate]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoAccess_nodeId]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccess_nodeId] ON [dbo].[umbracoAccess]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoAccessRule]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccessRule] ON [dbo].[umbracoAccessRule]
(
	[ruleValue] ASC,
	[ruleType] ASC,
	[accessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoDeployChecksum]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoDeployChecksum] ON [dbo].[umbracoDeployChecksum]
(
	[entityType] ASC,
	[entityGuid] ASC,
	[entityPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoLanguage_languageISOCode]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoLanguage_languageISOCode] ON [dbo].[umbracoLanguage]
(
	[languageISOCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoLog]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_umbracoLog] ON [dbo].[umbracoLog]
(
	[NodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoMigration]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoMigration] ON [dbo].[umbracoMigration]
(
	[name] ASC,
	[version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeObjectType]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeObjectType] ON [dbo].[umbracoNode]
(
	[nodeObjectType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeParentId]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeParentId] ON [dbo].[umbracoNode]
(
	[parentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeTrashed]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeTrashed] ON [dbo].[umbracoNode]
(
	[trashed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeUniqueID]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoNodeUniqueID] ON [dbo].[umbracoNode]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRedirectUrl]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRedirectUrl] ON [dbo].[umbracoRedirectUrl]
(
	[urlHash] ASC,
	[contentKey] ASC,
	[createDateUtc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_computerName]    Script Date: 13-10-2016 18:01:49 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_computerName] ON [dbo].[umbracoServer]
(
	[computerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoServer_isActive]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_umbracoServer_isActive] ON [dbo].[umbracoServer]
(
	[isActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoUser_userLogin]    Script Date: 13-10-2016 18:01:49 ******/
CREATE NONCLUSTERED INDEX [IX_umbracoUser_userLogin] ON [dbo].[umbracoUser]
(
	[userLogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cmsMacroProperty] ADD  CONSTRAINT [DF_cmsMacroProperty_macroPropertySortOrder]  DEFAULT ('0') FOR [macroPropertySortOrder]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_closed]  DEFAULT ('0') FOR [closed]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[umbracoExternalLogin] ADD  CONSTRAINT [DF_umbracoExternalLogin_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_cmsContentType_nodeId] FOREIGN KEY([contentType])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType] CHECK CONSTRAINT [FK_cmsContentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child] FOREIGN KEY([childContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent] FOREIGN KEY([parentContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType] FOREIGN KEY([Id])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1] FOREIGN KEY([AllowedId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1]
GO
ALTER TABLE [dbo].[cmsContentVersion]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId] FOREIGN KEY([ContentId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentVersion] CHECK CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsContentXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentXml] CHECK CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDataType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDataType] CHECK CONSTRAINT [FK_cmsDataType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDataTypePreValues]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId] FOREIGN KEY([datatypeNodeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDataTypePreValues] CHECK CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsDictionary]  WITH CHECK ADD  CONSTRAINT [FK_cmsDictionary_cmsDictionary_id] FOREIGN KEY([parent])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsDictionary] CHECK CONSTRAINT [FK_cmsDictionary_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId] FOREIGN KEY([templateId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId] FOREIGN KEY([templateNodeId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_umbracoNode_id] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id] FOREIGN KEY([UniqueId])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id] FOREIGN KEY([languageId])
REFERENCES [dbo].[umbracoLanguage] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id]
GO
ALTER TABLE [dbo].[cmsMacroProperty]  WITH CHECK ADD  CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id] FOREIGN KEY([macro])
REFERENCES [dbo].[cmsMacro] ([id])
GO
ALTER TABLE [dbo].[cmsMacroProperty] CHECK CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId] FOREIGN KEY([Member])
REFERENCES [dbo].[cmsMember] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id] FOREIGN KEY([MemberGroup])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId] FOREIGN KEY([NodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_umbracoNode_id] FOREIGN KEY([NodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId] FOREIGN KEY([versionId])
REFERENCES [dbo].[cmsContentVersion] ([VersionId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id] FOREIGN KEY([propertytypeid])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_umbracoNode_id] FOREIGN KEY([contentNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId] FOREIGN KEY([contentTypeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId] FOREIGN KEY([dataTypeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id] FOREIGN KEY([propertyTypeGroupId])
REFERENCES [dbo].[cmsPropertyTypeGroup] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id]
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId] FOREIGN KEY([contenttypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup] CHECK CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsContent]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType] FOREIGN KEY([propertyTypeId])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsTags_id] FOREIGN KEY([tagId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsTags_id]
GO
ALTER TABLE [dbo].[cmsTags]  WITH CHECK ADD  CONSTRAINT [FK_cmsTags_cmsTags] FOREIGN KEY([ParentId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTags] CHECK CONSTRAINT [FK_cmsTags_cmsTags]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_cmsTaskType_id] FOREIGN KEY([taskTypeId])
REFERENCES [dbo].[cmsTaskType] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_cmsTaskType_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser] FOREIGN KEY([parentUserId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser1] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser1]
GO
ALTER TABLE [dbo].[cmsTemplate]  WITH CHECK ADD  CONSTRAINT [FK_cmsTemplate_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTemplate] CHECK CONSTRAINT [FK_cmsTemplate_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id1] FOREIGN KEY([loginNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id1]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id2] FOREIGN KEY([noAccessNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id2]
GO
ALTER TABLE [dbo].[umbracoAccessRule]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id] FOREIGN KEY([accessId])
REFERENCES [dbo].[umbracoAccess] ([id])
GO
ALTER TABLE [dbo].[umbracoAccessRule] CHECK CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id]
GO
ALTER TABLE [dbo].[umbracoDeployDependency]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDeployDependency_umbracoDeployChecksum_id1] FOREIGN KEY([sourceId])
REFERENCES [dbo].[umbracoDeployChecksum] ([id])
GO
ALTER TABLE [dbo].[umbracoDeployDependency] CHECK CONSTRAINT [FK_umbracoDeployDependency_umbracoDeployChecksum_id1]
GO
ALTER TABLE [dbo].[umbracoDeployDependency]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDeployDependency_umbracoDeployChecksum_id2] FOREIGN KEY([targetId])
REFERENCES [dbo].[umbracoDeployChecksum] ([id])
GO
ALTER TABLE [dbo].[umbracoDeployDependency] CHECK CONSTRAINT [FK_umbracoDeployDependency_umbracoDeployChecksum_id2]
GO
ALTER TABLE [dbo].[umbracoDomains]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDomains_umbracoNode_id] FOREIGN KEY([domainRootStructureID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoDomains] CHECK CONSTRAINT [FK_umbracoDomains_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoNode_umbracoNode_id] FOREIGN KEY([parentID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoNode] CHECK CONSTRAINT [FK_umbracoNode_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoRedirectUrl]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID] FOREIGN KEY([contentKey])
REFERENCES [dbo].[umbracoNode] ([uniqueID])
GO
ALTER TABLE [dbo].[umbracoRedirectUrl] CHECK CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY([parentId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY([childId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode1]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id] FOREIGN KEY([relType])
REFERENCES [dbo].[umbracoRelationType] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id]
GO
ALTER TABLE [dbo].[umbracoUser]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser_umbracoUserType_id] FOREIGN KEY([userType])
REFERENCES [dbo].[umbracoUserType] ([id])
GO
ALTER TABLE [dbo].[umbracoUser] CHECK CONSTRAINT [FK_umbracoUser_umbracoUserType_id]
GO
ALTER TABLE [dbo].[umbracoUser2app]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2app_umbracoUser_id] FOREIGN KEY([user])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2app] CHECK CONSTRAINT [FK_umbracoUser2app_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser_id]
GO
USE [master]
GO
ALTER DATABASE [AarhusWebDev] SET  READ_WRITE 
GO
