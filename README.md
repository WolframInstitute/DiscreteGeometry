> ⚠️ Actively developed, experimental research code. The API may change without notice.

# 🔺 Discrete Geometry

![DiscreteGeometry](./infra.png)

Geometry and topology of combinatorial objects built from graphs.

Here the full combinatorial structure is used, in contrast to [InfraGeometry](https://github.com/WolframInstitute/InfraGeometry), which concentrates on geometry emerging from aggregation at large scale. This repo can be thought of as the smallest scale part of this effort.

📖 [**Wolfram Paclet Documentation**](https://www.wolframcloud.com/obj/hajek_pavel/DeployedResources/Paclet/WolframInstitute/DiscreteGeometry)

## 🎯 Goals

- ⛓️ Collect standard methods of chain complexes from graphs.
- 📐 Collect standard discrete geometry methods.
- ⚛️ Mirror Oliver Knill's [quantum calculus](https://www.quantumcalculus.org/).

## ⚙️ Installation

```wl
PacletInstall["https://www.wolframcloud.com/obj/hajek_pavel/DiscreteGeometry.paclet", ForceVersionInstall -> True]
Needs["WolframInstitute`DiscreteGeometry`"]
```

Requires [Wolfram Language](https://www.wolfram.com/language/) 14.3 or higher.

## 🙏 Funding

Pavel Hájek's work on this repository was partially supported by the John Templeton Foundation grant 63655, [Causality, Observers and Computation: A New Approach to Fundamental Physics and Metamathematics](https://www.templeton.org/grant/causality-observers-and-computation-a-new-approach-to-fundamental-physics-and-metamathematics) at the Wolfram Institute. The opinions expressed are those of the author and do not necessarily reflect the views of the John Templeton Foundation.

## 📜 Licence

- Code: [MIT](LICENSE)
- Mathematical content: [CC BY 4.0](LICENSE-CC-BY-4.0)
