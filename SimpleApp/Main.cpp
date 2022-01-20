
#include <string>
#include <vector>
#include <iostream>
#include <iomanip>

#include "OmniClient.h"
#include "pxr/usd/usd/stage.h"
#include "pxr/usd/usd/prim.h"
#include "pxr/usd/usd/primRange.h"
#include "pxr/usd/usdGeom/metrics.h"


using namespace pxr;

static void OmniClientConnectionStatusCallbackImpl(void* userData, const char* url, OmniClientConnectionStatus status) noexcept
{
	std::cout << "Connection Status: " << omniClientGetConnectionStatusString(status) << " [" << url << "]" << std::endl;
	if (status == eOmniClientConnectionStatus_ConnectError)
	{
		// We shouldn't just exit here - we should clean up a bit, but we're going to do it anyway
		std::cout << "[ERROR] Failed connection, exiting." << std::endl;
		exit(-1);
	}
}

// Startup Omniverse 
static bool startOmniverse()
{
	// Register a function to be called whenever the library wants to print something to a log
	omniClientSetLogCallback(
		[](char const* threadName, char const* component, OmniClientLogLevel level, char const* message)
	{
		std::cout << "[" << omniClientGetLogLevelString(level) << "] " << message << std::endl;
	});

	// The default log level is "Info", set it to "Debug" to see all messages
	omniClientSetLogLevel(eOmniClientLogLevel_Info);

	// Initialize the library and pass it the version constant defined in OmniClient.h
	// This allows the library to verify it was built with a compatible version. It will
	// return false if there is a version mismatch.
	if (!omniClientInitialize(kOmniClientVersion))
	{
		return false;
	}

	omniClientRegisterConnectionStatusCallback(nullptr, OmniClientConnectionStatusCallbackImpl);

	return true;
}


int main(int argc, char* argv[])
{
	if (argc != 2)
	{
		std::cout << "Please provide an Omniverse stage URL to read." << std::endl;
		return -1;
	}

	startOmniverse();

	UsdStageRefPtr stage = UsdStage::Open(argv[1]);
	if (!stage)
	{
		std::cout << "Failure to open stage.  Exiting." << std::endl;
		return -2;
	}

	// Print the up-axis
	std::cout << "Stage up-axis: " << UsdGeomGetStageUpAxis(stage) << std::endl;

	// Print the stage's linear units, or "meters per unit"
	std::cout << "Meters per unit: " << std::setprecision(5) << UsdGeomGetStageMetersPerUnit(stage) << std::endl;

	auto range = stage->Traverse();
	for (const auto& node : range)
	{
		std::cout << "Node: " << node.GetPath() << std::endl;
	}
	
	// The stage is a sophisticated object that needs to be destroyed properly.  
	// Since stage is a smart pointer we can just reset it
	stage.Reset();

	omniClientShutdown();
}



