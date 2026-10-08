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

## 📜 Licence

[MIT](https://opensource.org/license/mit) for the code.
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) for the mathematics and the ideas.
