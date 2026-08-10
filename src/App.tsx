import { BrowserRouter, Navigate, Route, Routes, useParams } from 'react-router-dom';
import { Layout } from './components/Layout';
import { WheelPage } from './pages/WheelPage';
import { HomePage } from './pages/HomePage';
import { ThemePage } from './pages/ThemePage';
import { QuizHubPage } from './pages/QuizHubPage';
import { QuizRunPage } from './pages/QuizRunPage';
import { BadgesPage } from './pages/BadgesPage';

// Anciens liens /themes/:themeId (sans niveau dans l'URL) : on ne peut pas
// deviner le niveau d'origine, on retombe sur grand_public plutôt que 404.
function LegacyThemeRedirect() {
  const { themeId } = useParams<{ themeId: string }>();
  return <Navigate to={`/themes/grand_public/${themeId}`} replace />;
}

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<Layout />}>
          <Route path="/" element={<WheelPage />} />
          <Route path="/reviser/:level" element={<HomePage />} />
          <Route path="/reviser" element={<Navigate to="/" replace />} />
          <Route path="/themes/:level/:themeId" element={<ThemePage />} />
          <Route path="/themes/:themeId" element={<LegacyThemeRedirect />} />
          <Route path="/quiz/run" element={<QuizRunPage />} />
          <Route path="/quiz/:level" element={<QuizHubPage />} />
          <Route path="/quiz" element={<Navigate to="/" replace />} />
          <Route path="/badges" element={<BadgesPage />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
