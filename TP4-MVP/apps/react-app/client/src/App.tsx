import { Toaster } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import NotFound from "@/pages/NotFound";
import { Route, Switch } from "wouter";
import ErrorBoundary from "./components/ErrorBoundary";
import { ThemeProvider } from "./contexts/ThemeContext";
import Home from "./pages/Home";
import Dashboard from "./components/Dashboard";
import ProjectDetails from "./components/ProjectDetails";
import AttendanceControl from "./components/AttendanceControl";
import Editais from "./components/Editais";
import TechStack from "./components/TechStack";
import DashboardLayout from "./components/DashboardLayout";
import Login from "./pages/Login";
import { useAuth } from "./_core/hooks/useAuth";
import { Redirect } from "wouter";

function Router() {
  const { isAuthenticated, loading } = useAuth();

  if (loading) {
    return <div>Loading authentication...</div>; // Or a skeleton loader
  }

  if (!isAuthenticated) {
    return (
      <Switch>
        <Route path="/login" component={Login} />
        <Route path="/editais" component={Editais} /> {/* Editais is public */}
        <Route path="/404" component={NotFound} />
        <Redirect to="/login" />
      </Switch>
    );
  }

  return (
    <Switch>
      <Route path="/login" component={Login} />
      <Route path="/">
        <DashboardLayout>
          <Dashboard />
        </DashboardLayout>
      </Route>
      <Route path="/dashboard">
        <DashboardLayout>
          <Dashboard />
        </DashboardLayout>
      </Route>
      <Route path="/projects/:projectId">
        <DashboardLayout>
          <ProjectDetails />
        </DashboardLayout>
      </Route>
      <Route path="/attendance">
        <DashboardLayout>
          <AttendanceControl />
        </DashboardLayout>
      </Route>
      <Route path="/editais">
        <DashboardLayout>
          <Editais />
        </DashboardLayout>
      </Route>
      <Route path="/techstack">
        <DashboardLayout>
          <TechStack />
        </DashboardLayout>
      </Route>
      <Route path="/404" component={NotFound} />
      {/* Final fallback route */}
      <Route component={NotFound} />
    </Switch>
  );
}

// NOTE: About Theme
// - First choose a default theme according to your design style (dark or light bg), than change color palette in index.css
//   to keep consistent foreground/background color across components
// - If you want to make theme switchable, pass `switchable` ThemeProvider and use `useTheme` hook

function App() {
  return (
    <ErrorBoundary>
      <ThemeProvider
        defaultTheme="light"
        // switchable
      >
        <TooltipProvider>
          <Toaster />
          <Router />
        </TooltipProvider>
      </ThemeProvider>
    </ErrorBoundary>
  );
}

export default App;
