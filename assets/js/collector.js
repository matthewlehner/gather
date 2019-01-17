(function() {
  "use strict";

  // Respect "Do Not Track" settings
  if (navigator.doNotTrack === "1") {
    return;
  }

  const hostname = window.location.host;
  const pathname = window.location.pathname;
  const referrer = document.referrer;

  const data = {
    p: pathname,
    h: hostname,
    r: referrer
  };

  function dataToParams(data) {
    return Object.keys(data)
      .map(key => encodeURIComponent(key) + "=" + encodeURIComponent(data[key]))
      .join("&");
  }

  const trackerSrc = "//" + hostname + "/collect?" + dataToParams(data);

  const img = document.createElement("img");
  img.setAttribute("alt", "");
  img.setAttribute("aria-hidden", true);
  img.src = trackerSrc;

  img.addEventListener("load", () => {
    document.body.removeChild(img);
  });

  document.body.appendChild(img);
})();
