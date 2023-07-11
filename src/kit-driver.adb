with Ada.Directories;

with Syn.File_Writer;
with Syn.Projects;

with Kit.Generate;
with Kit.Generate.Templates;
with Kit.Parser;
with Kit.Schema.Databases;
with Kit.Schema.Types;

with Kit.Command_Line;

package body Kit.Driver is

   -------------
   -- Execute --
   -------------

   procedure Execute
     (Path : String;
      Ada_2022 : Boolean)
   is
      pragma Unreferenced (Ada_2022);
   begin
      Kit.Schema.Types.Create_Standard_Types;

      declare
         Db : constant Kit.Schema.Databases.Database_Type :=
                Kit.Parser.Read_Kit_File (Path);
         Project : constant Syn.Projects.Project :=
                     Kit.Generate.Generate_Database (Db);
         File    : Syn.File_Writer.File_Writer;
         Current : constant String :=
                     Ada.Directories.Current_Directory;
      begin
         Ada.Directories.Set_Directory
           (Kit.Command_Line.Output_Directory);
         Syn.Projects.Write_Project (Project, File);
         Kit.Generate.Templates.Copy_Template_Packages
           (Db, Ada.Directories.Current_Directory);
         Ada.Directories.Set_Directory (Current);
      end;
   end Execute;

end Kit.Driver;
