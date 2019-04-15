

Given a set of newly registered user for day $t \in\{0,1,…,T\}​$ in out study period, we define a class lable $Y_t \in\{1,0\}​$ such that
$$ {\center}
Y_t = \begin{cases}
1 & \text{ if user is active for day } t\\
0 & \text{ if user is inactive for day } t\end{cases}
$$
And also, we collected user features $\{x_0,x_1,…,x_R\}​$ for day $t \in\{0,1,…,R\}​$, where $R<T​$. 

We would like to predict the user retention rate given the define window $[R+1, T]$,
$$
P(\sum_{R+1}^T Y_t \geq 1|{x_0, ..., x_R, Y_0, Y_1, ...Y_R}).
$$
The objective is to use machine learning models to optimize different forms of objective functions in both training set and test set.

## Fractions

| Command          | Description                                   | Output                  |
| :--------------- | :-------------------------------------------- | :---------------------- |
| \frac            | Build a fraction like so: \frac{1}{2}         | $\frac{1}{2}$           |
| \frac{\frac{}}{} | You can nest fractions: \frac{\frac{1}{2}}{2} | $\frac{\frac{1}{2}}{2}$ |

## Greek letters

(capitalize by capitalizing the command)

| Command  | Description | Output |
| :------- | :---------- | :----- |
| \alpha   | alpha       | α      |
| \beta    | beta        | β      |
| \gamma   | gamma       | γ      |
| \delta   | delta       | δ      |
| \epsilon | epsilon     | ϵ      |
| \zeta    | zeta        | ζ      |
| \eta     | eta         | η      |
| \theta   | theta       | θ      |
| \iota    | iota        | ιι     |
| \kappa   | kappa       | κ      |
| \lambda  | lambda      | λ      |
| \mu      | mu          | μ      |
| \nu      | nu          | ν      |
| \xi      | xi          | ξ      |
| o        | omicron     | o      |
| \pi      | pi          | π      |
| \rho     | rho         | ρ      |
| \sigma   | sigma       | σ      |
| \tau     | tau         | τ      |
| \upsilon | upsilon     | υ      |
| \phi     | phi         | ϕ      |
| \chi     | chi         | χ      |
| \psi     | psi         | ψ      |
| \omega   | omega       | ω      |

## Logic

| Command | Description | Output |
| :------ | :---------- | :----- |
| \forall | For all     | ∀      |
| \exists | Exists      | ∃      |
| \lor    | Or          | ∨      |
| \land   | And         | ∧      |
| \veebar | Xor         | ⊻      |
| \neg    | Not         | ¬      |

## Operators

| Command | Description | Output |
| :------ | :---------- | :----- |
| \times  | Times       | ×      |
| \cdot   | Dot         | ⋅      |
| \div    | Division    | ÷      |
| \pm     | Plus minus  | ±      |

## Relation

| Command | Description           | Output |
| :------ | :-------------------- | :----- |
| \neq    | Not equal             | ≠      |
| \approx | Approximately equal   | ≈      |
| \leq    | Less than or equal    | ≤      |
| \geq    | Greater than or equal | ≥      |
| \ll     | Much less than        | ≪      |
| \gg     | Much greater than     | ≫      |

## Sets

(Often you can put an “n” before the command and get the negation)

| Command    | Description                             | Output |
| :--------- | :-------------------------------------- | :----- |
| \supset    | Proper superset                         | ⊃      |
| \supseteq  | Superset                                | ⊇      |
| \subset    | Proper Subset                           | ⊂      |
| \subseteq  | Subset                                  | ⊆      |
| \in        | Member                                  | ∈      |
| \emptyset  | Empty set                               | ∅      |
| \mathbb{R} | Set of real numbers                     | ℝ      |
| \cup       | Set union (belonging to A OR B)         | ∪      |
| \cap       | Set intersection (belonging to A AND B) | ∩      |

## Super-/Subscript (Exponents / Indices)

| Command | Description                                          | Output   |
| :------ | :--------------------------------------------------- | :------- |
| ^       | Use ^ for superscript. Example: x^2                  | $x2$     |
| ^{}     | Use ^{} for exponents with >1 digit. Example: x^{10} | $x^{10}$ |
| _       | Use _ for subscript. Example: x_0                    | $x_0$    |
| _{}     | Use _{} for subscript with >1 digit. Example: x_{10} | $x_{10}$ |

## Others

| Command       | Description | Output |
| :------------ | :---------- | :----- |
| \infty        | Infinity    | ∞      |
| \partial      | Partial     | ∂      |
| \hat{}        | Estimator   | θ̂      |
| \sqrt[root]{} | Square root | 4      |