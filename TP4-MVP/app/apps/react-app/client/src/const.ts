

export const UNAUTHED_ERR_MSG = "Unauthenticated";

export function getLoginUrl(returnPath?: string) {
  const url = new URL(import.meta.env.VITE_OAUTH_PORTAL_URL);
  url.searchParams.set("appId", import.meta.env.VITE_APP_ID);
  url.searchParams.set("redirectUri", window.location.origin + "/api/oauth/callback");
  if (returnPath) {
    url.searchParams.set("returnPath", returnPath);
  }
  return url.toString();
}
