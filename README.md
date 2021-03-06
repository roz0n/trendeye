<p align="center" width="100%">
    <img width="128px" height="128px" src="./README-Icon.png"> 
</p>

<h1 align="center">Trendeye (Beta)</h1>

<p align="center" width="100%">
    Graphic design trend classification powered by CoreML and images from <a href="https://www.trendlist.org">TrendList.org</a>
</p>

## Authors

- [@roz0n](https://www.linkedin.com/in/rozon)

> Design, development, deployment, testing, and everything in-between

## Screenshots

<p align="center" width="100%">
    <img src="./README-Screenshots.png"> 
</p>

## Stack

**Client:** Swift, UIKit (fully programmatic MVC, zero storyboards or nibs), AVKit, CoreML

**Server:** TypeScript, Node, Redis, Express (namely [JSDOM](https://github.com/jsdom/jsdom) and Node's [Stream API](https://nodejs.org/api/stream.html#stream_stream) for web and image scraping respectively)

> For more information about the Trendeye back-end, kindly visit the [Unofficial TrendList API](https://github.com/roz0n/trendlist-api) repo.

**Deployment:** Terraform, Docker, Ubuntu (via DigitalOcean), NGINX

**Design:** Figma, Adobe Illustrator

> To view complete designs, kindly visit [this](https://www.figma.com/file/yb2EerWCmNrCjhuYVYR150/TRENDEYE-iOS-App?node-id=321%3A582) Figma artboard.

## Features

Trendeye is a simple app with a simple purpose and feature-set but contains some interesting UX goodies built from the ground up:

- Snapchat-style full-screen camera view input powered by AVKit (namely `AVCaptureSession`)
- Instagram-style image panning and zooming (leveraging `UIPanGestureRecognizer` and `UIPinchGestureRecognizer` in tandem)
- Stretchy table headers (using a modified version of Michael Nachbaur's very eloquent [solution](https://nachbaur.com/2020/05/06/stretchable-tableview-header/))

Most importantly, the above was accomplished without a single third-party dependency. Though, in some ways I wish I had used _some_ as I encountered a fair number of bugs in UIKit along the way 🌝

## Roadmap

- **_Greatly_** improve the accuracy of the image classification model
- Implement photo framing and cropping using `UIGraphicsImageRenderer`
- Persist classification results locally on the device using CoreData and subsequently sync them with `CloudKit`

## Run Locally

## Run Tests

## Acknowledgements

- [Trend List](https://www.trendlist.org/)
- [Indian Type Foundry](https://www.indiantypefoundry.com/)
- [FontShare](https://www.fontshare.com/)

... and most notably, the legion of talented designers/artists/studios that have had their work cataloged on the [Trend List](https://www.trendlist.org) blog. Thank you.

## Contact Me

For support, bug reports, inquiries, or a stern talking to, email arnold@rozon.dev

## License

[MPL-2.0 License](https://choosealicense.com/licenses/mpl-2.0/)
