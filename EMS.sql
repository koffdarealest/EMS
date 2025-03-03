INSERT INTO [dbo].[Departments]
           ([Name], [IsDeleted], [CreatedAt], [UpdatedAt], [DeletedAt], [CreatedBy], [UpdatedBy], [DeletedBy])
     VALUES
           ('Sales Department', 0, SYSDATETIME(), SYSDATETIME(), NULL, 1, 1, NULL),
           ('Human Resources', 0, SYSDATETIME(), SYSDATETIME(), NULL, 1, 1, NULL),
           ('Accounting Department', 0, SYSDATETIME(), SYSDATETIME(), NULL, 1, 1, NULL),
           ('IT Department', 0, SYSDATETIME(), SYSDATETIME(), NULL, 1, 1, NULL),
           ('Marketing Department', 0, SYSDATETIME(), SYSDATETIME(), NULL, 1, 1, NULL);

		   
use emstest
select * from Users
select * from UserAuths
