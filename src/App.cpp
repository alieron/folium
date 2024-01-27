#include "CreateGUI.h"

FoliumGUI::Application* FoliumGUI::CreateApplication(int argc, char** argv)
{
	FoliumGUI::ApplicationSpecification spec;
	spec.Name = "Folium Example";

	FoliumGUI::Application* app = new FoliumGUI::Application(spec);
	//app->SetMenubarCallback([app]()
	//	{
	//		if (ImGui::BeginMenu("File"))
	//		{
	//			if (ImGui::MenuItem("Exit"))
	//			{
	//				app->Close();
	//			}
	//			ImGui::EndMenu();
	//		}
	//	});
	return app;
}