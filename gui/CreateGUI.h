#include "AppGUI.h"

extern FoliumGUI::Application* FoliumGUI::CreateApplication(int argc, char** argv);
bool g_ApplicationRunning = true;

int main(int argc, char** argv)
{

    while (g_ApplicationRunning)
    {
        FoliumGUI::Application* app = FoliumGUI::CreateApplication(argc, argv);
        app->Run();
        delete app;
    }

    return 0;
}