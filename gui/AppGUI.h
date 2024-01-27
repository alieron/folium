#pragma once

#include <functional>
#include <memory>
#include <string>
#include <vector>

#include "imgui.h"

struct GLFWwindow;

namespace FoliumGUI {

	struct ApplicationSpecification
	{	
		//Default windows settings
		std::string Name = "Folium App";
		uint32_t Width = 1600;
		uint32_t Height = 900;
	};

	class Application
	{
	public:
		Application(const ApplicationSpecification& applicationSpecification = ApplicationSpecification());
		~Application();

		static Application& Get();

		void Run();
		void SetMenubarCallback(const std::function<void()>& menubarCallback) { m_MenubarCallback = menubarCallback; }

		void Close();

		float GetTime();
		GLFWwindow* GetWindowHandle() const { return m_WindowHandle; }

		//static VkInstance GetInstance();
		//static VkPhysicalDevice GetPhysicalDevice();
		//static VkDevice GetDevice();

		//static VkCommandBuffer GetCommandBuffer(bool begin);
		//static void FlushCommandBuffer(VkCommandBuffer commandBuffer);

		static void SubmitResourceFree(std::function<void()>&& func);

	private:
		void Init();
		void Shutdown();
	private:
		ApplicationSpecification m_Specification;
		GLFWwindow* m_WindowHandle = nullptr;
		bool m_Running = false;

		float m_TimeStep = 0.0f;
		float m_FrameTime = 0.0f;
		float m_LastFrameTime = 0.0f;

		std::function<void()> m_MenubarCallback;
	};

	// Implemented by CLIENT
	Application* CreateApplication(int argc, char** argv);
}