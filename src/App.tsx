import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { Layout } from './components/Layout';
import { WheelPage } from './pages/WheelPage';
import { HomePage } from './pages/HomePage';
import { ThemePage } from './pages/ThemePage';
import { QuizHubPage } from './pages/QuizHubPage';
import { QuizRunPage } from './pages/QuizRunPage';
import { BadgesPage } from './pages/BadgesPage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<Layout />}>
          <Route path="/" element={<WheelPage />} />
          <Route path="/reviser" element={<HomePage />} />
          <Route path="/themes/:themeId" element={<ThemePage />} />
          <Route path="/quiz" element={<QuizHubPage />} />
          <Route path="/quiz/run" element={<QuizRunPage />} />
          <Route path="/badges" element={<BadgesPage />} />
        </Route>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
